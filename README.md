# Pydantic AWS Lambda layer
A lambda layer with a .NET runtime for all to use. License is MIT.

[![Build Status](https://travis-ci.com/Leaf-Agriculture/dotnet-lambda-layer.svg?branch=master)](https://travis-ci.com/Leaf-Agriculture/dotnet-lambda-layer)

## Versions
**Microsoft.NETCore 2.1.16 and 3.1.2**

The version is not strictly defined. Is the most recent one when a merge to `master` was performed.

## Creation
To create the package we use the docker images provided by the gods, [Lambci](https://github.com/lambci/). We build this layer using `lambci/lambda:build` image.

## Deploy
The deployment is fully automatic, performed by travis. We create the layer package using a `makefile` and deploy it to every region in AWS using a custom, but simple, bash script.

## ARNs
Here is the full list of ARNs of the lambdas.

```
# Microsoft.NETCore.App 2.1
arn:aws:lambda:ap-northeast-1:558258168256:layer:dotnet21:1
arn:aws:lambda:ap-northeast-2:558258168256:layer:dotnet21:1
arn:aws:lambda:ap-south-1:558258168256:layer:dotnet21:1
arn:aws:lambda:ap-southeast-1:558258168256:layer:dotnet21:1
arn:aws:lambda:ap-southeast-2:558258168256:layer:dotnet21:1
arn:aws:lambda:ca-central-1:558258168256:layer:dotnet21:1
arn:aws:lambda:eu-central-1:558258168256:layer:dotnet21:1
arn:aws:lambda:eu-north-1:558258168256:layer:dotnet21:1
arn:aws:lambda:eu-west-1:558258168256:layer:dotnet21:1
arn:aws:lambda:eu-west-2:558258168256:layer:dotnet21:1
arn:aws:lambda:eu-west-3:558258168256:layer:dotnet21:1
arn:aws:lambda:sa-east-1:558258168256:layer:dotnet21:1
arn:aws:lambda:us-east-1:558258168256:layer:dotnet21:1
arn:aws:lambda:us-east-2:558258168256:layer:dotnet21:1
arn:aws:lambda:us-west-1:558258168256:layer:dotnet21:1
arn:aws:lambda:us-west-2:558258168256:layer:dotnet21:1

# Microsoft.NETCore.App 3.1
arn:aws:lambda:ap-northeast-1:558258168256:layer:dotnet31:1
arn:aws:lambda:ap-northeast-2:558258168256:layer:dotnet31:1
arn:aws:lambda:ap-south-1:558258168256:layer:dotnet31:1
arn:aws:lambda:ap-southeast-1:558258168256:layer:dotnet31:1
arn:aws:lambda:ap-southeast-2:558258168256:layer:dotnet31:1
arn:aws:lambda:ca-central-1:558258168256:layer:dotnet31:1
arn:aws:lambda:eu-central-1:558258168256:layer:dotnet31:1
arn:aws:lambda:eu-north-1:558258168256:layer:dotnet31:1
arn:aws:lambda:eu-west-1:558258168256:layer:dotnet31:1
arn:aws:lambda:eu-west-2:558258168256:layer:dotnet31:1
arn:aws:lambda:eu-west-3:558258168256:layer:dotnet31:1
arn:aws:lambda:sa-east-1:558258168256:layer:dotnet31:1
arn:aws:lambda:us-east-1:558258168256:layer:dotnet31:1
arn:aws:lambda:us-east-2:558258168256:layer:dotnet31:1
arn:aws:lambda:us-west-1:558258168256:layer:dotnet31:1
arn:aws:lambda:us-west-2:558258168256:layer:dotnet31:1
```

## Usage
This was built for people who need to run custom C# scripts in lambdas but won't, or can't, use the available runtime. The following example shows how to build a compatible project and to run it in the lambda using python.

First, we need to create our C# project. The following commands will generate and build a lambda compatible `Hello World`. The commands will create a project using the .NET framework installed in your computer. If you want, you can pass the framework with the `--framework` flag. Check [here](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish) for more info on the `dotnet publish` command.

```bash
$ dotnet new console -o example
$ cd example
$ dotnet publish -r linux-x64 --self-contained false -o ../sample
```

After we have our C# project built, we need to make a small alteration in the `./sample/example.runtimeconfig.json` file. See this [issue](https://github.com/dotnet/core/issues/2186) for more info. Just add the following to your configurations:

```json
{
  "runtimeOptions": {
    "configProperties": {
      "System.Globalization.Invariant": true
    }
  }
}
```

After that, we can package it with our lambda and run `.dll` files using the `dotnet` command. See the following python function for an example. We are assuming the `sample` directory is in the same directory as the python script.


```python
import subprocess

def handler(e, c):
    subprocess.run(['dotnet', '--info'])
    subprocess.run(['dotnet', 'sample/example.dll'])
    return e
```

### .NET build
You need to build your project correctly for it to be able to work in the lambda. See the folowing example:

