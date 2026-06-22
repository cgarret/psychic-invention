---
title: MOC Books
date: 2026-06-03, 14:14
tags:
  - moc
  - mocbooks
  - "#imported"
aliases: []
---
___
## 🚀Quick Notes
---
- [[Idea of MOC Books]]
- [[Tasks of MOC Books]]

## 📝 All Notes
---
```base
filters:
  and:
    - file.hasTag("mcofiction")
views:
  - type: table
    name: ChaptersBook
    filters:
      and:
        - level == "02"
        - module == "CH"
        - book.startsWith("Shades of Silence - Fractured mosaic")
    groupBy:
      property: book
      direction: ASC
    sort:
      - property: chapter_number
        direction: ASC

```




## 📒Misc.
---
>Not sure, keep here

```dataview
List file.book where contains(file.module,"CH")
```