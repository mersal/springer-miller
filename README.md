### Process:

- takes PAR Springer-Miller group linked reservations report and prints tab-separated list of name/room number combinations
- this list can then be imported into any label template for printing (e.g. Avery template 5160)
- reservation name values formatted as: 

`<last_name1>/<last_name2>`

or

`<last-name1>/<last-name2>, <first-name1>/<last-first>`

or

`<last_name>, <first_name>/<first_name>`

or 

`<last_name>, <first_name>`

`--splitrooms` option splits name into separate labels for roommates. otherwise, both names will be printed on the same label

works only with PAR Springer-Miller Report: 5->A->R [ listed as: Groups/Others -> Linked Reservations -> Linked Reservations ]

### Usage:  

`reservations_label.pl <file name> [--splitrooms]`


