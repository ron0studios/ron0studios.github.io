# Structure of Agents
---
>[!summary] When tackling a problem by means of Artificial Intelligence, it is important to distinguish the different factors in which we structure our [[Agent|agents]]. This will not only help us classify the kind of problem we are dealing with, but also help us find the appropriate tool or algorithm to use to tackle the problem. Below are some basic terms used when describing an agent. 

## Table driven agent
A **table driven** agent maintains a table of every possible **precept** of the environment. Using the precepts given as an index to the table, the agent is then tasked to fill in every cell of the table with the *optimal sequence of actions*, such that when the agent is faced with a real task, it can simply look up its current precept on the table and respond accordingly.

While this will technically solve a large number of AI problems, it is obvious that it will be very infeasible to actually be performed for 2 big reasons:
- Due to the enormous number of possible precepts in most real world environments, even with maximum abstractions, the sizes of the action table will grow to be too large to store within a machine.
- Due to the enormous number of possible precepts in most real world environments, it will be incredibly difficult to fill in **every cell of the table** with an optimal sequence of actions. 

To quote from the book:
> [!quote] Consider the automated taxi: the visual input from a single camera (eight cameras is typical) comes in at the rate of roughly 70 megabytes per second (30 frames per second, 1080×720 pixels with 24 bits of colour information). This gives a lookup table with over $10^{600,000,000,000}$ entries for an hour’s driving. Even the lookup table for chess—a tiny, well-behaved fragment of the real world—has (it turns out) at least $10^{150}$ entries. In comparison, the number of atoms in the observable universe is less than $10^{80}$

## Simple reflex agent
![[Drawing 2024-09-03 10.40.14.excalidraw|-right]]A **simple reflex agent** acts upon the environment by receiving a *precept* of its environment, and following a set of prescribed rules on which action to take in response. 
Note that this agent is only successful if its environment is **completely observable**. The agents logic also must be completely inclusive of all possible precepts, meaning that the conditional logic may miss out on some important edge cases. This is especially common in complex environments like that of a self driving car.

## Model based agent
![[image-20240903105025024.png|-huge-left]]A **model based agent** builds upon the [[#Simple reflex agent]] structure by introducing an **internal state** to the model. This state will include information that the agent can store the results or information of past precepts or actions. 
The internal state can be modified and updated by using two kinds of *models*. 

Firstly, we introduce a **transition model** which is knowledge on "how the environment works". More specifically, it will tell the agent what the general effects of its actions will be, as learned from previous interactions with the environment. For example for a self driving car, the transition model will tell the agent that if it increases the brake on the top right wheel then the car will start turning right. 
Secondly, we introduce a **sensor model**, which is knowledge on how the state of the environment is reflected in the precepts of the agent. For example, our self driving car might be given several depth sensors on the front and sides of the vehicle, which is then fed in as precepts to the agent as a string of numbers. The sensor model's job is to figure out what these strings of numbers actually mean in relation to the environment. 

## Goal based agent
![[image-20240903110847720.png|-huge-right]] A **goal based agent** differs from the [[#Model based agent]] structure, in that instead of having predefined logic, we try to optimise a certain **discrete goal**, which will map our actions with how much closer it will get us to our goal.





This **goal** may be a real life entity, such as a location an agent needs to get to, as would be the case for a self driving car. However, the goal can also be more abstract. It could be a function we need to optimise, or even a function we need to find ourselves^[inverse reinforcement learning]. Nevertheless, in order to find which action best achieves our goal, we need to "emulate" the action and see what difference it makes to achieving our goal. Hence, we have the extra label in the diagram for *what it will be like if I do action **A***.

## Utility based agent
![[image-20240903111652160.png|-huge-left]] A **utility based agent** differs from the [[#Goal based agent]] in that, unlike a discrete goal such as the destination of a self driving car or a desired chess position, this agent optimises on **utility**.






**Utility** is more *continuous* measurement describing a sort of *performance measure* on how well the agent is performing *alongside* a discrete goal. For example, there are probably many routes that a self driving car can take to reach its **goal** but several of these routes may be inconvenient for the person in the car, for example, since they may be too loud, too long or passing through marshy ground. Utility allows us to distinguish between these. 

