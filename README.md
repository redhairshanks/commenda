# README

Thought process

- Base table - datatypes
  - This table contains types of blocks 
  - id
  - type - enum
  - properties - json 
  - content - json 

- Derived table - block_units



class for block - contains polymorphic relations 
class for table - name, id
class for table_row - has list of cells
class for cells - type, text