
# Components
# <small>What are they and what do I do with them?</small>

Component-oriented programming is a parallel of object-oriented programming.
Components are objects that compose other objects, as opposed to objects that
inherit from other object types. Instead of inheriting attributes and methods
from a class, a component-made object gets methods and attributes by adding
to itself a component. This way we don't have problems of multiple inheritance,
and we also have smaller objects.

But this means that elements don't really exist. They are just a structure to
store components.

In this program, we took that to the letter. An element's only usefulness is its
ID attribute. All that matters in a element, aside from its ID, is its components.

But imagine making an element by hand like that. You have to create every one of
its components, create an empty new element, and then call an theoretical
'attach' method to associate the element to the components. That's super
troublesome. Each of those components probably need many construction
parameters. Just creating a single element would require 20 lines of code.
Imagine making 20 different elements. Ugh.

So I automated things using something called Data-Driven Design. In code, this
means that all parameters are already preset somewhere, specifying each element
of the game. This is storage of parameters is what I call the Database.

The automation was made via a manager. The manager's element-maker is a method
called "new_element", that receives a string with the element's name. The manager
then looks for every database entry that contains that string. Each component has
a section in the database. And each section has a filename that corresponds to an
element's name. The database entry that I meant is literally the filename. So if it
finds a filename that corresponds to a component, a component is automatically made
for that element. The content of the filename is the parameters for constructing
the component.

Sounds good doesn't it?

But how do these components communicate with each other? They clearly cannot _see_
each other. Well, I use signals for that. Signals are registered by actions. To
know more about actions, read the `src/actions/readme.md` file.

Also, components can be automatically created.
Just run the `add_component.lua` file with lua.
