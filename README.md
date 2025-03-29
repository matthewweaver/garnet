<img width="200" src="https://github.com/user-attachments/assets/41a5839f-fadb-4823-bae2-f4711b796275"> 

<br>

# Garnet 
**G***enerative* **A***dversarial* **R***einforcement* **N***etwork* **E***xploitation* **T***ool*

<br>

### Table of Contents

- [Garnet](#garnet)
    - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
    - [Summary](#summary)
    - [Project Rationale](#project-rationale)
    - [Literature Review](#literature-review)
  - [Architecture](#architecture)
    - [Deep Exploit](#deep-exploit)
    - [Applying Generative Adversarial Networks](#applying-generative-adversarial-networks)
  - [Getting Started](#getting-started)
    - [Documentation](#documentation)
    - [Installation](#installation)
    - [Usage](#usage)
      - [Setup](#setup)
      - [Metasploit](#metasploit)
      - [Configure](#configure)
      - [Train](#train)
      - [Test](#test)
      - [Metasploitable 3](#metasploitable-3)
      - [cGAN](#cgan)
  - [Branches](#branches)

<br>

## Overview

### Summary
Combining a GAN with a Deep Reinforcement Learning agent to produce novel approaches for penetration testing.

<br>

### Project Rationale
- to explore the combination of GANs and Deep Reinforcement Learning, and their application to Cybersecurity
- to simplify and productionise cutting edge academic papers into open source code, able to scale to real world scenarios

<br>

### Literature Review

*Valea, O., & Oprisa, C. (2020). Towards Pentesting Automation Using the Metasploit Framework. Proceedings - 2020 IEEE 16th International Conference on Intelligent Computer Communication and Processing, ICCP 2020, 171–178. https://doi.org/10.1109/ICCP51029.2020.9266234*

*Yang, Y., & Liu, X. (2022). Behaviour-Diverse Automatic Penetration Testing: A Curiosity-Driven Multi-Objective Deep Reinforcement Learning Approach. https://arxiv.org/abs/2202.10630v1*

*Maeda, R., & Mimura, M. (2021). Automating post-exploitation with deep reinforcement learning. Computers & Security, 100, 102108. https://doi.org/10.1016/J.COSE.2020.102108*

*Mnih, V., Badia, A. P., Mirza, M., Graves, A., Lillicrap, T. P., Harley, T., Silver, D., & Kavukcuoglu, K. (2016). Asynchronous Methods for Deep Reinforcement Learning. https://arxiv.org/abs/1602.01783*

*Hoang, L. van, Nhu, N. X., Nghia, T. T., Quyen, N. H., Pham, V. H., & Duy, P. T. (2022). Leveraging Deep Reinforcement Learning for Automating Penetration Testing in Reconnaissance and Exploitation Phase. Proceedings - 2022 RIVF International Conference on Computing and Communication Technologies, RIVF 2022, 41–46. https://doi.org/10.1109/RIVF55975.2022.10013801*

*Pfau, D., & Vinyals, O. (2016). Connecting Generative Adversarial Networks and Actor-Critic Methods. https://arxiv.org/abs/1610.01945*

*Chen, J., Hu, S., Zheng, H., Xing, C., & Zhang, G. (2023). GAIL-PT: An intelligent penetration testing framework with generative adversarial imitation learning. Computers & Security, 126, 103055. https://arxiv.org/pdf/2204.01975*

*Ho, J., & Ermon, S. (2016). Generative Adversarial Imitation Learning. https://arxiv.org/abs/1606.03476*

*Henderson, P., Chang, W.-D., Bacon, P.-L., Meger, D., Pineau, J., & Precup, D. (2017). OptionGAN: Learning Joint Reward-Policy Options using Generative Adversarial Inverse Reinforcement Learning. http://arxiv.org/abs/1709.06683*

*Huang, J., Hao, J., Juan, R., Gomez, R., Nakamura, K., & Li, G. (2023). GAN-Based Interactive Reinforcement Learning from Demonstration and Human Evaluative Feedback. Proceedings - IEEE International Conference on Robotics and Automation, 2023-May, 4991–4998. https://doi.org/10.1109/ICRA48891.2023.10160939*

*Kasi, K. (n.d.). Using Generative Adversarial Imitation Learning for Policy Learning in Agent-based Simulation Environments. http://cs230.stanford.edu/projects_fall_2020/reports/55806303.pdf*

*Luo, T., Pearce, T., Chen, H., Chen, J., & Zhu, J. (2024). C-GAIL: Stabilizing Generative Adversarial Imitation Learning with Control Theory. https://arxiv.org/abs/2402.16349*

*Yu, L., Zhang, W., Wang, J., & Yu, Y. (2016). SeqGAN: Sequence Generative Adversarial Nets with Policy Gradient. 31st AAAI Conference on Artificial Intelligence, AAAI 2017, 2852–2858. https://doi.org/10.1609/aaai.v31i1.10804*

<br>


## Architecture
![Diagram](architecture.drawio.svg)

<br>

### Deep Exploit
This project builds upon Deep Exploit, a fully automated penetration testing tool leveraging Metasploit framework. This was created by Isao Takaesu (@13o-bbr-bbq), the original code can be found here
https://github.com/13o-bbr-bbq/machine_learning_security

Further improvements were added by the team at TheDreamPort for competitions which I have included for training against Metasploitable 3 VM and improved performance.
https://github.com/TheDreamPort/deep_exploit

In addition to this, I have containerised the code so it is much simpler to setup and use. Only Docker is required and you can automatically build an environment with the exact package versions which have been tested as working. This uses Ubuntu Linux 18.04, and configures the docker image automatically. I also improved the regex to fix multiple bugs and created the setup script to work in a containerised environment. Furthermore I have documented how to use the code.

<br>


### Applying Generative Adversarial Networks

A GAN trains an unsupervised Generator using a Discriminator. The Discriminator learns to differentiate a real example from a fake one provided by the Generator, and through a reward signal helps the Generator learn to create better fakes. It has the potential to generate novel exploits, which can be a significant improvement over exploring the vast action space through trial and error. This could be particularly effective for the security application as trial and error would draw attention to an agent trying to break into a system.

In the excellent GAIL-PT paper https://arxiv.org/pdf/2204.01975 referenced in the literature review, the researchers applied Generative Adversarial Imitation Learning to Deep Exploit. The actor/critic agent replaces the Generator from a GAN, so the Actor learns a policy and outputs a recommended action when given a state; the Critic guides the Actor through executing actions against a training machine and rewarding if successful; and a Discriminator guides the agent by rewarding actions which imitate the expert knowledge. The networks are alternately trained with the actor/critic agent learning a policy through trial and error, and the Discriminator learning the probability a state-action pair came from the expert knowledge or the agent. 

The limitation is that expert data is expensive to gather. In the GAIL paper, the data is gathered by the same code used to train the model and therefore does not provide significant benefit besides speeding up training. A solution could be to pre-train a Generator module of a GAN on historical exploits and plug this into the advantage function along with the GAIL discriminator. As the Generator learns unsupervised through reward signals, it can learn latent features behind the historical data rather than mimicking expert knowledge. The agent could then optimise how often to explore the latent action space, imitate the expert data, or rely on the policy from its own training. 

So the training takes place in two stages - first the GAN is trained, by providing historical data to a discriminator which learns to differentiate between the output of a generator (given noise) and the real exploits whilst also giving feedback to the generator to improve its generation. 
After training the GAN, the RL agent can be trained through trial and error against vulnerable machines.

Finally, during testing, the RL agent chooses between the input from the GAN Generator or the GAIL Discriminator if the agent thinks it is better than any exploits it has learned during training or if it runs out of high value actions.

Numerous architectures were tested and I settled on using a Conditional GAN (cGAN) to allow the generator to select between the distinct combinations of port, exploit and payload which NMap determined the machine might be vulnerable to. Without this it would likely generate novel combinations which were extremely unlikely to work. 

GANs are notoriously fragile to train; due to the adversarial nature it is a balancing act to ensure one does not outperform the other. In order to stabilise training a number of techniques were used including: 
- <b>label smoothing</b> - prevents the discriminator becoming overconfident
- <b>noise injection</b> - adds entropy to stabilise training
- <b>balanced learning rates</b> - puts the discriminator at a disadvantage to the generator
- <b>gradient clipping</b> - prevents exploding gradients
- <b>wasserstein loss</b> - avoid vanishing gradient
- <b>dropout regularisation</b> - prevent overfitting
  



<br>

## Getting Started

### Documentation
To understand how the deep exploit code works see [here](./Documentation.md)

### Installation

The following steps assume a unix environment or unix based shell if on windows e.g. gitbash/WSL2. Only Docker is required on the host machine.

1. Clone the Garnet repository and open the directory in your shell
```
git clone https://github.com/matthewweaver/garnet
cd garnet
```
<br>

2. Build the docker image locally
```
time DOCKER_BUILDKIT=1 docker build -t garnet .
```

<br>

### Usage

#### Setup
To test against a vulnerable machine, the simplest option is to download a virtual machine such as Metasploitable 2. 
https://docs.rapid7.com/metasploit/metasploitable-2/

If using VirtualBox to run the VM, to allow communication between docker and the VM you must modify the network setting of the VM in VirtualBox. Simply change the network adapter to Bridged Adapter, then verify they can communicate by getting the IP of the VM with ```ifconfig``` and look for the eth0 inet IP address. Keep this ```vm_ip``` handy as it is used later. 

Run the docker image (either run from docker desktop UI or ```docker run -dit garnet```).

Open a shell on the running image (either from docker desktop UI or ```docker exec -it <container_id> /bin/bash```).

Ping the IP address of the VM from earlier

```
ping <vm_ip>
```
Ensure it receives bytes back.

Also save the IP address for the docker image ```docker_ip``` with ```ifconfig``` as above.

Set ```server_host``` to your ```<docker_ip>``` in ```deep_exploit/config.ini```
```
> nano config.ini

[Common]
server_host : <docker_ip>
server_port : 55553
msgrpc_user : test
msgrpc_pass : test1234
```

Ensure ProxyList info in ```/etc/proxychains.conf``` matches the ```proxy_host``` and ```proxy_port``` in ```deep_exploit/config.ini```
```
> nano /etc/proxychains.conf
...snip...

[ProxyList]
...snip...
socks4  127.0.0.1 1080
```
<br>

#### Metasploit

To run Deep Exploit requires starting the Metasploit framework console. In the shell on the docker image run

```
msfdb init
msfconsole
```
then start the RPC service to allow Deep Exploit to command it remotely
```
load msgrpc ServerHost=<docker_ip> ServerPort=55553 User=test Pass=test1234
```
<br>

#### Configure

You can adjust the parameters of the job in the ```deep_exploit/config.ini``` file under ```[A3C]```

```train_worker_num```: the number of workers to run with python threading. Higher consumes more resources on your machine but greatly improves performance.

```train_max_num```: the total number of runs the workers will perform before it will end training

```train_max_steps```: the number of times it will run a particular exploit

```train_tmax```: timeout it will wait for the exploit

<br>

#### Train

Create a new shell on the docker image and run DeepExploit in training mode
```
cd deep_exploit
. ./virtualenv/bin/activate
time python3 DeepExploit.py -t <vm_ip> -m train
```
Note: 
If hit error ```UnicodeEncodeError: 'ascii' codec can't encode characters in position 99-105: ordinal not in range(128)```
```
apt-get install language-pack-en
export LC_ALL=$(locale -a | grep UTF-8)
```
The output will be a trained model stored as checkpoint file under ```deep_exploit/trained_data```
and a training report under ```deep_exploit/report/train``` containing the vulnarabilities that were successfully exploited on the training machine.

https://html-preview.github.io/?url=https://github.com/matthewweaver/garnet/blob/main/deep_exploit/report/train/DeepExploit_train_report.html

<br>

#### Test

Create a new shell on the docker image and run DeepExploit in testing mode
```
cd deep_exploit
. ./virtualenv/bin/activate
time python3 DeepExploit.py -t <vm_ip> -m test
```

This time it will leave open an active session for each shell which was successful in gaining access to the target IP. These can be listed with the following command in the msfconsole shell
```
sessions --list
```
and one can be activated to enable remote access as follows
```
sessions -i <session_id>
ls
```

<br>

#### Metasploitable 3
The latest version of the Metasploitable VM provides more vulnerabilities and the capability to run either windows or linux OS, as well as greater configurability.

To install clone this repo
https://github.com/rapid7/metasploitable3

Then run the respective quick-start vagrant up command to use a prebuilt image.

<br>

#### cGAN
To train a cGAN, choose hyperparameters in ```config.ini``` under the heading GAN including:
- <b>epochs</b> - the number of complete passes through the entire training dataset during training
- <b>batch_size</b> -  the number of samples  processed together in one forward and backward pass during training
- <b>latent_dim</b> - the size of the latent space (the input noise vector) used by the generator to produce outputs

Next run

```python gan/cGAN.py```

once a target_tree.json has been created along with the historic data in successful_actions.csv. In this case it consists of vulnerabilities defined by the Metasploitable 2 documentation.

This saves the Keras model as cGAN.keras under gan/models/, which will be loaded by future runs of DeepExploit.

<br>

## Branches
If you want the original Deep Exploit tool production ready with Docker, the standalone is on the branch ```deep-exploit```.

If you want to try GAIL-PT, which uses adversarial imitation learning to help train the agent with "expert knowledge", the changes from this paper https://arxiv.org/pdf/2204.01975 referenced in the literature review have been added on the branch ```gail-pt```.

The main branch of this repository contains the additional code for combining a GAN with an RL Agent; Garnet.