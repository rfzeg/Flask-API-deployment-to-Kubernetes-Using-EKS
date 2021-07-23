# Deploying a containerized Flask API on Amazon Elastic Kubernetes Service (Amazon EKS)


This project shows how to containerize and deploy a Flask API to a Kubernetes cluster using Docker, AWS EKS, CodePipeline, and CodeBuild.

The Flask app used for this project consists of a simple API with three endpoints:

- `GET '/'`: This is a simple health check, which returns the response 'Healthy'. 
- `POST '/auth'`: This takes a email and password as json arguments and returns a JWT based on a custom secret.
- `GET '/contents'`: This requires a valid JWT, and returns the un-encrpyted contents of that token. 

The app relies on a secret set as the environment variable `JWT_SECRET` to produce a JWT. 

## Dependencies

- Python 3.6 or higher. Check the current version using: `python --version`  
- Docker Engine
    - Installation instructions for all OSes can be found [here](https://docs.docker.com/install/).
 - AWS Account
     - You can create an AWS account by signing up [here](https://aws.amazon.com/#).

## Initial setup
1. Locally clone this project to begin working on the project  
2. Create a new virtual environment and activate it  
3. Install python dependencies `pip install -r requirements.txt`   
4. Set environment variables  

You do need the following two variables available in your terminal environment:

JWT_SECRET - The secret used to make the JWT, for the purpose of this project the secret can be any string.
LOG_LEVEL - It represents the level of logging. It is optional to be set. It has a default value as 'INFO', but when debugging an app locally, you may want to set it to 'DEBUG'.

To add these to your terminal environment, run the following:

```
 export JWT_SECRET='myjwtsecret'
 export LOG_LEVEL=DEBUG
```
Verify:
```
echo $JWT_SECRET
echo $LOG_LEVEL
```

5.  **Run the app locally**
    Run the app locally using the Flask server. From the root directory of the downloaded repository, run:

    ```
    python main.py
    ```
    Check the endpoints:  
    <pre>
    curl --request GET 'http://localhost:8080/'
    </pre>

    To try the `/auth` endpoint, use the following command, replacing email/password as applicable to you:

    ```
    export TOKEN=`curl --data '{"email":"abc@xyz.com","password":"mypwd"}' --header "Content-Type: application/json" -X POST localhost:8080/auth  | jq -r '.token'`

    ```

    This calls the endpoint 'localhost:8080/auth' with the email/password as the message body. The return value is a JWT token based on the secret string you supplied. We are assigning that secret to the environment variable 'TOKEN'. To see the JWT token, run:

    ```
     echo $TOKEN

    ```

    ![Project auth endpoint locally](doc/images/endpoint_auth_access.gif) 

    To try the `/contents` endpoint which decrypts the token and returns its content, run:

    ```
     curl --request GET 'http://localhost:8080/contents' -H "Authorization: Bearer ${TOKEN}" | jq .

    ```

    You should see the email id that you passed in as one of the values.

    ![Project contents endpoint locally](doc/images/endpoint_contents_access.gif) 

## Acknowledgement  

This project is based on the following repository:   

```
https://github.com/udacity/FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS
```
