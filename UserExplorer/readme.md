#  Infinite scrolling and finite lazy scrolling

Incremental adjustment of the scroll indicator may be the only way out if the total numbercof elements is unknown or huge. Sometimes such a "runaway" indicator can cause irritation. 
Luckily, the API can often tell us the total number of elements. In this case, we can use the UITableViewDataSourcePrefetching protocol, and specifically its method: `tableView(_:prefetchRowsAt:)`. This method gets the indexPath of the cells to be displayed based on the current scroll direction and speed. In this method, you can run operations to query data for the mentioned cells.
To prevent requests from overlapping, you can use the current execution flag variable.
