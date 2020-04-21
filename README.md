Autoroller
==========

The purpose of this addon is to automate rolling on loot. It was designed for ZG coins and bijou's, but is flexible
enough to be used for other items.

Usage
=====

After installing it, typing /autoroller will display settings for it, which are mostly self explanatory.

By default, autoroller is off. If it is off, autoroller will do nothing at all. You can it on and off as shown.

```
/autoroller off
or
/autoroller on
```

Running /autoroller print will display what it is doing. For example.

```
/autoroller print
autoroller is ON
===========================
Rolling greed on Green Hakkari Bijou
Rolling pass on Black Diamond
rolling need on Neltharion's Tear
```

To add Azuresong Mageblade to the need list, you can either type the name, or link the item.

```
/autoroller need Azuresong Mageblade
or
/autoroller need <SHIFT CLICK A MAGEBLADE>
```

If you replace need with greed or pass, you can automate rolling that on the item as well.

```
/autoroller greed Azuresong Mageblade
/autoroller pass <SHIFT CLICK A MAGEBLADE>
```

To no longer mark an item to be automatically rolled on, you can use remove, for example

```
/autoroller remove Azuresong Mageblade
or
/autoroller remove <SHIFT CLICK A MAGEBLADE>
```

You can clear everything with

```
/autoroller clear
```

Finally, there are convienence functions for all ZG coins and bijous. For example.

```
/autoroller need ZG
/autoroller remove ZG
```

Notes
=====

- Items are saved when you logout the game, per character.
- I'm a lazy coder so you automatically pass on black diamonds. This helps me, but I think it helps you too !

Feature Suggestions
===================

- A better GUI like interface (unlikely)
- Let you link multiple items to add to the list. For example

```
/autoroller need <Azuresong Mageblade> <Staff of Dominanace>
```