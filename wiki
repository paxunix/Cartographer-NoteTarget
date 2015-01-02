= Cartographer_NoteTarget v0.3=

A World of Warcraft addon to supply a slash command (`/ctnt`) to capture a few details for the targeted unit and save them in a Cartographer map note.

Aliases for `/ctnt` include `/ctnotetarget` and `/nt`.

Any text supplied after the slash command will be used instead of the corresponding DogTag code for the target for which you are creating the note.

If you have nothing targeted and type text after the slash command, a note is instead created at your current location with a title of the given text along with the name of the subzone you are in.


== Configuration ==

The Cartographer_NoteTarget menu is available from the Cartographer menu on your World Map.  All of the addon's options are configurable through the menu.


== Menu Hierarchy ==

 * Foe
   * Color
   * Icon
   * DogTag code

 * Friend
   * Color
   * Icon
   * DogTag code

 * Location
   * Color
   * Icon

 * Default creator

The *Foe* submenu configures note settings for unfriendly targets, while the *Friend* submenu does the same for friendly targets.  The other submenu choices are:

|| Color || Sets the color to be used for the note's title, as appearing on the note's tooltip. ||
|| Icon || Sets the icon to be used for the note.  You can choose from the default icons, as well as from any installed Cartographer icon packs. ||
|| DogTag code || Sets the DogTag text used to determine what information is captured about the target when creating the note's info text.  They are called DogTags because of the name of the library Cartographer_NoteTarget uses to interpret them.  Documentation for them can be found [http://www.wowace.com/wiki/LibDogTag-2.0/Tags here].  For most users, the default values will probably be sufficient.  Any text supplied after the slash command (e.g. `/ctnt this is a test`) will override the DogTag code for the given target. ||

The "Default creator" menu option allows you to specify the text that appears in the Creator field of new notes.  The default is "NoteTarget".  If the text field is empty, the creator text used will be the name of the character creating the note.


== Limitations ==

 * Due to game API constraints, the map note is placed at your current location, regardless of how far away you actually are from your target.

 * The Ace2 API used to display the icons in the *Icon* submenu currently does not allow specifying a subset of a larger image as an icon.  This is why the predefined raid icons (i.e. Skull, Diamond, Cross, etc.) do not appear properly within the Icon menu.  On the map, however, they will appear correctly.

 * Changing the Friend or Foe icon or color will currently not change the icons or note title colors of existing map notes.


== Bugs and Feature Requests ==

 * Please report any bugs and feature requests via the Issues tab at the top of this page.  Not many people will do that, so I also keep an eye on the [http://www.wowace.com/forums/index.php?topic=6390.0 WowAce forum topic] for this addon as well.  You can post both bugs and feature requests to the forum topic.

== Download History ==

|| 2008-03-22 || Cartographer_NoteTarget-2.3-r65325.zip || Updated externals to use LibDogTag-2.0 ||
|| 2008-03-25 || Cartographer_NoteTarget-2.4-r65880.zip || TOC bump for 2.4 ||
|| 2008-03-27 || Cartographer_NoteTarget-2.4-66604.zip || Fix dogtag2 embed ||
|| 2008-04-24 || Cartographer_NoteTarget-2.4-71397.zip || Support targetless note creation ||
