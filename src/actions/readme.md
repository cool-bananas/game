
# Actions
# <small>What are they and what do I do with them?</small>

Actions in this program is a group of structures that can hold strings that are
associated with functinos. Those associations are signals. Furthermore, actions
are organized into controllers. A controller is a group of actions. Controllers
are programmed to automatically register its actions based on a string it
receives as a parameter for its constructor. This string represents a section
in the database, namely the file `src/database/actions.lua`, which details
every controller and its every actions. Basically, actions dictate how the game
works at a certain state. A controller is a group of actions of a single gamestate.

A controller thus can be activated or deactivated. Activating a controller means
its actions are now potential things that can happen in game. Deactivating means
that these actions will no longer happen.

Actions are a bunch of triggers with callbacks. Those are the signals of which
we spoke of earlier. An action is activated when the trigger is called, or, namely,
when the corresponding signal is emitted.

The code for signals is fairly simple. You should check the [hump lib][signals]
to see how they work. I shamelessly copied their code structure and method names.

[signals]:http://hump.readthedocs.io/en/latest/signal.html
