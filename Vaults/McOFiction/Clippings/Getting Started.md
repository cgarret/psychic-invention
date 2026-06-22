---
title: "Getting Started"
source: "https://www.obsidiancopilot.com/en/docs/getting-started"
author:
  - "[[loganyang]]"
published:
created: 2026-05-27
description: "Quickstart guide to get you up and running."
tags:
  - "clippings"
---
Quickstart guide to get you up and running.

---

## Installation

- Open Community Plugins settings page, click on the Browse button.
- Search for "Copilot" in the search bar and find the plugin with this exact name.
- Click on the Install button.
- Once the installation is complete, enable the Copilot plugin by toggling on its switch in the Community Plugins settings page.
![Install Copilot](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Finstall-copilot.jpeg&w=3840&q=75)

Now you can see the chat icon in your leftside ribbon, clicking on it will open the chat panel on the right!

## Quick Setup

Before you can start chatting with Copilot, you need to connect it to your preferred AI model provider by adding your API key.

For example, if you want to use OpenAI’s models, follow these steps:

1. **Get Your API Key from OpenAI**  
	*Note: An API key is different from ChatGPT Plus — you do not need a ChatGPT Plus subscription to get an API key.* In Obsidian, go to Copilot Basic Settings -> API Keys -> Set Keys.
	![OpenAI Setting 1](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Fopenai-setting-1.jpeg&w=3840&q=75)
	Go to OpenAI API Platform by clicking the link to Get OpenAI Key.
	![OpenAI Setting 2](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Fopenai-setting-2.jpeg&w=3840&q=75)
	On [OpenAI Platform](https://platform.openai.com/api-keys) dashboard, log in or sign up if you don’t have an account. Then generate and copy your API key from the dashboard. *Note: Ensure you have a billing account setup and your wallet has a positive balance.*
	![OpenAI Setting 3](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Fopenai-setting-3.jpeg&w=3840&q=75)
2. **Add Your API Key in Obsidian Copilot**  
	Open Obsidian, go to **Settings → Copilot Settings → Basic Settings → API Keys**, and paste your OpenAI API key into the **OpenAI API Key** field for verification.
	![OpenAI API Key Setting 4](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Fopenai-setting-4.jpeg&w=3840&q=75)
3. **Choose Your AI Model**  
	In Copilot settings, select an OpenAI model such as `gpt-4o` or `gpt-4o-mini` as your default model. Click **Save and Reload** to apply the changes.
4. **Start Chatting**  
	Open the Copilot Chat pane, select your chosen OpenAI model from the dropdown menu, and start your conversation!
	![Copilot Chat](https://www.obsidiancopilot.com/_next/image?url=%2Fimages%2Fdocs%2Fcopilot-chat.jpeg&w=3840&q=75)

You can use this same process to set up API keys from other AI model providers by obtaining their API keys and entering them in the corresponding fields in Copilot’s API Keys settings.

## Glossary

#### LLM

A **large language model** is an advanced AI model trained on vast amounts of text to understand and generate human-like language, powering features like chat, summarization, and writing assistance in Copilot. It's the "brain" behind the AI's language abilities.

#### API

An **Application Programming Interface** is a set of rules and tools that allow different software programs to communicate and work together, such as Copilot connecting with AI services or external tools. APIs enable Copilot to access powerful AI models and features.

#### API Rate Limits / Quotas

Restrictions set by AI service providers on how many requests or how much data you can send or receive within a certain time period. These limits help manage server load and can affect how often or how much you can use AI features.

#### RAG

**Retrieval-Augmented Generation** is a technique that enhances a language model’s output by first retrieving relevant external information—typically using embeddings—and then generating responses based on both the query and the retrieved content.

#### Embeddings

A method of converting text or notes into numerical representations that capture their meaning, enabling the AI to compare and find related content effectively. Embeddings help the AI understand your notes beyond just keywords.

#### Token

A small unit of text (like a word or part of a word) that AI models process when reading or generating language. Tokens are used to measure how much text the AI can handle at once and often relate to usage limits or costs.

#### Context Window

The amount of information or text the AI can consider at one time when generating a response. A larger context window means the AI can understand and use more of your notes or conversation history in its answers.

#### Index

A structured summary or map of all the notes and files in your Obsidian vault that helps the AI quickly find and reference relevant information. Think of it as a table of contents that makes searching faster and more accurate.

#### MCP (Model Context Protocol)

A standard way for different AI tools and models to share and use context information, making it easier to connect various AI capabilities within Copilot. It helps expand what the AI can do by integrating external tools smoothly.

#### Partitioning

The process of breaking down a large collection of notes or data into smaller, manageable parts to improve performance and avoid errors during indexing or searching. It helps the system handle big vaults without slowing down or crashing.

#### Vector Store

A specialized database that stores information as mathematical vectors, allowing the AI to find related content based on meaning rather than exact words. It’s like a smart filing system that understands the context of your notes.

#### CoT (Chain of Thought)

A reasoning process where the AI explains its thinking step-by-step to arrive at an answer, making its responses more transparent and easier to understand. It’s like the AI “showing its work” when solving problems.