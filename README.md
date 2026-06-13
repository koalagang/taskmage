# Taskmage

Taskwarrior-inspired task management tool following the todo.txt specification

## Roadmap

N.B. the roadmap is not a strict specification for exactly when certain features
will be added. It's just a general guide for the order I intend to add them in.

### 0.1

- `add`
  - add a task to todo.txt
  - specify task description, context, tag, priority and due date
- `done`
  - mark a task as done
- `list`
  - list all tasks or any subset of tasks (archived, deleted, pending,
    completed, with a given project, context, creation date or due date, or
    regex the task description)
- `delete`
  - move a task from todo.txt to deleted.txt
  - will prompt y/n by default but can be forced with `--force` flag or using an
    environmental variable
- `purge`
  - delete a task from deleted.txt
  - will prompt y/n by default but can be forced with `--force` flag or using an
    environmental variable
  - note that a task must first be deleted before being purged
- `archive`
  - move completed tasks from todo.txt to done.txt
  - optionally specify the exact task(s) to archive, instead of archiving all

### 0.2

- `list`
  - add the ability to modify the order tasks are displayed in
  - add the ability to hide tasks with certain metadata
    - change due date text colour
    - yellow if due date is within a week
    - red if due date is tomorrow, today or in the past
    - do not change colour if task is already done
- `append`
  - add more to the end of an existing task
- `modify`
  - change a task's priority, due date, contexts and projects
- `edit`
  - edit task(s) directly within your favourite text editor
- `undo`
  - reverse a completed task to an incomplete state

### 0.3

- tickler
  - specify a tickler file or URL, which can be opened using `open` command
  - e.g. if task 1 has `tickler:~/Documents/foobar.txt`, `tm open 1` will open
    up `~/Documents/foobar.txt` in your favourite text editor
  - e.g. if task 2 has `tickler:https://github.com`, `tm open 2` will open up
    GitHub in your favourite web browser
  - can be used with video files, image files, audio files, etc.
- ability to operate on tasks in given ranges
  - e.g. `tm list pri:B-D` to list tasks of priority B, C and D
  - e.g. `tm done 1-3` to mark tasks 1 to 3 as complete
  - e.g. `tm delete 2 4` to delete tasks 2 and 4

### 0.4+

- hooking system
  - allows you to configure taskmage to automatically run a custom script before
    or after given functions
- custom commands
  - allows you to add your own taskmage commands, e.g. `tm mycommand`
- custom metadata
  - supports using your own custom metadata in the format `key:value` at the end
    of the task
- add flake.nix so that taskmage can easily be installed using flakes
- write proper documentation
- add shell completion
- error-handling for files not respecting the todo.txt spec?
- add an optional TUI?

## AI declaration

AI was used to assist with writing some of the regular expressions used in this
program. Everything else is human-written.

## License

Taskmage, also known as taskmage or `tm`, is licensed under the permissive MIT
license Copyright (c) 2026 Gabriel, also known as
[koalagang](https://github.com/koalagang).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
