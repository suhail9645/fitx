import 'dart:convert';

import 'package:fitx/src/data/repositories/remote/message_opearation_imp.dart';
import 'package:fitx/src/domain/model/message_result/message_result.dart';
import 'package:fitx/src/domain/model/trainer_list/result.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_barell.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../config/constants/sized_box.dart';
import 'bloc/message_bloc.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required this.trainer});
  final Result trainer;
  @override
  Widget build(BuildContext context) {
    // messageBloc.add(MessageInitialEvent());
    TextEditingController controller = TextEditingController();
    List<MessageResult> messages = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(trainer.user!.username!),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(trainer.user!.profilePicture ??
                'https://leadership.ng/wp-content/uploads/2023/03/davido.png'),
          ),
          spaceforwidth10
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessageInitialState) {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder(
                      stream: state.channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          MessageResult messageResult =
                              MessageResult.fromJson(jsonDecode(snapshot.data));
                          messages.add(messageResult);

                          return ListView.builder(
                            // reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    messages[index].message!.sender!.id ==
                                            trainer.user!.id
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                    padding: const EdgeInsets.all(12),
                                 
                                    decoration:  BoxDecoration(
                                      color: messages[index].message!.sender!.id ==
                                            trainer.user!.id? Color.fromARGB(255, 213, 89, 155):Colors.amber,
                                      borderRadius: BorderRadius.only(
                                        topLeft:const Radius.circular(7),
                                        topRight:const Radius.circular(8),
                                        bottomRight:messages[index].message!.sender!.id ==
                                             trainer.user!.id
                                        ? const Radius.circular(12):Radius.zero,
                                          bottomLeft:messages[index].message!.sender!.id !=
                                             trainer.user!.id
                                        ?const Radius.circular(12):Radius.zero,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          messages[index].message!.text!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )),
                    Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 230, 113, 185),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(19),
                          bottomRight: Radius.circular(19),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: const Icon(Icons.file_open)),
                            spaceforwidth10,
                            InkWell(
                                onTap: () {}, child: const Icon(Icons.image)),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Message',
                                    floatingLabelStyle:
                                        TextStyle(color: whiteColor),
                                    hintStyle: TextStyle(color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                              child: const Icon(Icons.send_sharp),
                              onTap: () async {
                                await MessageOperationsImp().sendTextMessage(
                                    trainer.user!.id!,
                                    controller.text,
                                    state.channel);
                              },
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
