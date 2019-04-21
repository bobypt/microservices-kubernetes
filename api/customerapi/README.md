# Customer Api

## Build project

 ```npm install```

 ## Start app
 ```npm start```

 Application will start locally and listen on port 8080.

 ## Test
 health url -  ```curl localhost:8080/api/v1/customerapi/health```
 get customer details -  ```curl localhost:8080/api/v1/customerapi/customers/123456```

 ## Build docker image
```docker build -t msdemo/customerapi .```

## Start a container
```docker run -p 8080:8080 --name customerapi -t msdemo/customerapi```

## Stop the api
```docker rm -f customerapi```