import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../models/routine.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_dialogs.dart';
import 'widgets/reminder_dialog.dart';
import 'widgets/tag_dialog.dart';

class NewRoutinePage extends StatefulWidget {
  final RoutineModel routineModel;

  const NewRoutinePage({this.routineModel});
  @override
  _NewRoutinePageState createState() => _NewRoutinePageState();
}

class _NewRoutinePageState extends State<NewRoutinePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<String> tags = [];
  DateTime reminder;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.routineModel != null) {
      _titleController.text = widget.routineModel.title;
      _descriptionController.text = widget.routineModel.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.routineModel == null
            ? Text("New Routine")
            : Text("Edit Routine"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // new routine field
                    TextFormField(
                      controller: _titleController,
                      maxLines: 1,
                      validator: Validators.validateTitle(),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "New Routine",
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // note field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Add Note",
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // tag button
                        IconButton(
                            icon: Icon(
                              Icons.local_offer,
                              color: ColorUtils.textColor,
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              tags = await addTag(context, addedTags: tags);
                            }),
                        // alarm button
                        IconButton(
                          icon: Icon(
                            Icons.alarm,
                            color: ColorUtils.textColor,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            reminder = await addReminder(context);
                          },
                        ),
                        // repeat button
                        IconButton(
                          icon: Icon(
                            Icons.repeat,
                            color: ColorUtils.textColor,
                          ),
                          onPressed: () {},
                        ),
                        // delete button
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: ColorUtils.textColor,
                          ),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  // ad button field
                  child: SizedBox(
                    width: getScreenWidth(context),
                    height: 50.0,
                    child: BlocConsumer<RoutineCubit, RoutineState>(
                      listener: (context, state) {
                        if (state is RoutineSuccess) {
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is RoutineLoading) {
                          return SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return TextButton(
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () => add(context),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void add(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final date = DateTime.now().millisecondsSinceEpoch;
      final routine = RoutineModel(
        id: date.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        reminder: reminder.millisecondsSinceEpoch,
        tags: tags,
      );

      if (reminder == null) {
        return CustomDialogs.showSnackBar("Please pick date");
      }

      BlocProvider.of<RoutineCubit>(context).addRoutine(routine.toMap());
    }
  }
}
