# DeepExploit

DeepExploit is an automated penetration testing tool that uses reinforcement learning to perform penetration testing. It leverages the Metasploit framework to interact with the target environment and execute exploits.


## Components

### Msgrpc
The Msgrpc class is responsible for interacting with the Metasploit RPC server. It provides methods to authenticate, execute commands, and retrieve information from Metasploit.

### Metasploit
The Metasploit class represents the penetration testing environment. It initializes the Metasploit RPC client, reads configuration settings, and provides methods to gather information about the target, execute exploits, and manage sessions.

### ParameterServer
The ParameterServer class defines the global neural network model and optimizer. It is responsible for maintaining the global weights and providing methods to update and retrieve these weights.

### LocalBrain
The LocalBrain class defines the local neural network model for each thread. It provides methods to build the model, define the learning method, and update the global weights using gradients.

### Agent
The Agent class represents the entity that interacts with the environment. It uses the actor-critic model to decide which actions to take based on the current state. It maintains a memory of experiences to learn from.

### Environment
The Environment class represents the penetration testing environment for each thread. It initializes the Metasploit environment, agent, and utility functions. It provides methods to run the learning or testing process.

### Worker Thread
The Worker Thread class represents a worker thread that executes the learning or testing process. It initializes the environment and provides methods to run the process.

### Configuration
The configuration settings are stored in the config.ini file. This file contains settings for Metasploit, Nmap, A3C, and other components. Ensure you update this file with the appropriate settings for your environment.

## Workflow Overview
### Initialization:

The script starts by importing necessary libraries and defining constants.
It initializes the Metasploit environment and reads configuration settings from config.ini.

### Command Line Arguments:

The script parses command line arguments to get the target IP address, mode (train/test), and optional port and service.

### Metasploit Initialization:

The Metasploit class is instantiated with the target IP address.
It reads configuration settings and initializes the Metasploit RPC client.

### Nmap Scan:

The script executes an Nmap scan against the target IP address to gather information about open ports and services.
The results are saved to an XML file.

### Exploit and Payload Lists:

The script retrieves the list of available exploits and payloads from Metasploit.
It creates an exploit tree and target information based on the Nmap scan results.

### Training (run method in Worker Thread class):

Each thread represents an agent that interacts with the environment.
The agent starts by pulling the global model weights from the ParameterServer.
The agent performs actions in the environment (e.g., scanning, exploiting) and collects experiences.
The agent uses the actor-critic model to decide actions:
The actor outputs a probability distribution over possible actions.
The critic evaluates the chosen action by estimating the value function.
The agent stores experiences in its memory and periodically updates the global model using these experiences.
The agent pushes the updated weights back to the ParameterServer.

### Exploitation and Post-Exploitation:

The agent executes exploits based on the learned policy.
If an exploit is successful, the agent may perform post-exploitation tasks to gather more information or pivot to other targets.