Autolooter
==========

The purpose of this addon is to automate rolling on loot. It was designed for ZG coins and bijou's, but is flexible
enough to be used for other items.

Usage
=====

After installing it, typing /autolooter will display settings for it, which are mostly self explanatory.

By default, autolooter is off. If it is off, autolooter will do nothing at all. You can it on and off as shown.

```
/autolooter off
or
/autolooter on
```

Running /autolooter print will display what it is doing. For example.

```
/autolooter print
Autolooter is ON
===========================
Rolling greed on Green Hakkari Bijou
Rolling pass on Black Diamond
rolling need on Neltharion's Tear
```

To add Azuresong Mageblade to the need list, you can either type the name, or link the item.

```
/autolooter need Azuresong Mageblade
or
/autolooter need <SHIFT CLICK A MAGEBLADE>
```

If you replace need with greed or pass, you can automate rolling that on the item as well.

```
/autolooter greed Azuresong Mageblade
/autolooter pass <SHIFT CLICK A MAGEBLADE>
```

To no longer mark an item to be automatically rolled on, you can use remove, for example

```
/autolooter remove Azuresong Mageblade
or
/autolooter remove <SHIFT CLICK A MAGEBLADE>
```

Finally, there are convienence functions for all ZG coins and bijous. For example.

```
/autolooter need ZG
/autolooter remove ZG
```