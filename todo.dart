import 'dart:html';

ButtonElement taskButton = querySelector('#newTaskButton');
InputElement taskText = querySelector('#newTaskText');
UListElement todoList = querySelector('#todoList');

void main() {
  taskButton.onClick.listen(addTask);
  taskText.onKeyPress.listen(enterTask);
}

void insertListElement(String newTaskName) {
  if (newTaskName.isEmpty) {
    return;
  }

  LIElement newTodo = new LIElement();
   newTodo.classes.add("task");

  ButtonElement editButton = new ButtonElement();
  editButton.text = "Edit";
  editButton.classes.add("editButtonClass");

  ButtonElement deleteButton = new ButtonElement();
  deleteButton.text = "Delete";
  deleteButton.onClick.listen(removeTask);

  SpanElement taskSpan = new SpanElement();
  taskSpan.text = newTaskName;
  taskSpan.classes.add("taskName");

  ButtonElement scratchButton = new ButtonElement();
  scratchButton.text = "Scratch";
  scratchButton.onClick.listen(scratchTask);


  newTodo.children..add(editButton)
    ..add(deleteButton)
    ..add(scratchButton)
    ..add(taskSpan);

  todoList.children.add(newTodo);

  taskText.value = '';
}

void addTask(Event e) {
  insertListElement(taskText.value);
}

void enterTask(Event e) {
  var keyEvent = new KeyEvent.wrap(e);

  if (keyEvent.keyCode == KeyCode.ENTER) {
    insertListElement(taskText.value);
  }
}

void removeTask(Event e) {
  var task = (e.target as ButtonElement).parent;
  task.remove();
}

void scratchTask(Event e) {
  var task = (e.target as ButtonElement).parent;
  for (var element in task.children) {
    if (element.classes.contains("taskName")) {
      element.style.textDecoration = "line-through";
    }
  }
}