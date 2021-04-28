# Cast Iron 
## Postgres Recipe

This is an example of how to incorporate Cast-Iron into your existing project that is making use of Postgres. 

### Cast-Iron Integration
This assumes that your existing project contains docker images and is brought up through the use of a 
docker-compose file. A `Makefile` has been created here to help in the coordination of multiple docker-compose files
and ensuring that everything is brought up and down in the right order. 

#### docker-compose.yml
This is your projects docker-compose and there shouldn't need to be any changes to it. 

#### Makefile
This creates the commands for calling multiple `docker-compose` files at once. Make sure to update this to call
your original projects docker-compose in addition to the cast-iron docker-compose file so that both come up when
`make up` is run. 

### Getting Started
#### Steps Already Completed in this Project
* Bring in the Git Submodule by running:   
`git submodule add git@github.com:black-cape/cast-iron-docker-compose.git`
  * For more information on git submodules see: https://git-scm.com/book/en/v2/Git-Tools-Submodules
  