# Description

This is simple app created to demonstrate how to execute some code in parallel process. In this case I achieved this by creating cluster and executing code in separate process on this cluster using `future` package.

# Why?

The problem I met while developing were heavy calculations in shiny app and unstable connection to shiny server. 
When user were waiting dozen of minutes to finish calculations, sometimes it could happen to disconnect app from the server and all progress ended in trach. So why not to perform calculations in separate, independent process which is insensitive to application crash or application close?

# TODOs
1. Inform user that process on cluster has finished
2. Add error handling to cluster calculations