# Contributing to Snap Labs

We really welcome your additions to this collection of labs. Here are the quick explanation of how to help:

* **If you find typos**, hop right in and open a pull request
* **If you want to request new labs**, it's helpful to start by opening an issue
* **If you have a tutorial to share**, open a pull request that follows the guidelines below

If you ever have questions, [hop into our Slack team](http://slack.snap-telemetry.io)!

## Tutorial Guidelines

For the sake of ease-of-use, here are the practices we would like all contributions to follow.

### Folder Structure

To design your folder structure:

* Fork, clone and `cd` into the `snap-labs/` folder
* Create a new folder for your tutorial
  * If the tutorial is simple enough to fit into a single markdown file, use the README.md as your post. See example in `introduction-task-manifest`
  * If the tutorial is best separated out into parts, create multiple sections as separate files. See [this fantastic tutorial from Slack](https://github.com/slackapi/Slack-Ruby-Onboarding-Tutorial) for an example of how this looks in practice
* Include any code snippets you want in the folder. See [advanced-deployment-docker-snap-influxdb-grafana/](advanced-deployment-docker-snap-influxdb-grafana/) for an example of this

### Introduction, Advanced or Topic?

We designed a very simple organization system to get us started:

* **`introduction`** designed to be an easy-to-follow, specific tutorial
* **`advanced`** for more complex interaction of multiple features
* **`topic`** for interesting subjects that don't smoothly fit into these :point_up:

Each tutorial should fall into one of these categories. Examples:

* `introduction-distributed-workflow` or `introduction-snmp-plugin`
* `advanced-graphite-plugin` or `advanced-distributed-workflow`
* `topic-normalizing-data` or `topic-monitoring-kubernetes`

### What should I write about? 

Anything you want others to know how to do with Snap! We hope to have at least one tutorial for every plugin, so you can start by picking one and writing about it!

### Tips and Tricks

For great labs, use some of these lessons learned by us:

* When animation is better than words, [make gifs with licecap][1]!
* You can make assumptions! For example, [this post](introduction-grafana-snap-app/README.md) focuses on Ubuntu 16.04 as the OS but links to others
* It's best for if the tutorial folder length is < 32 characters (to render cleanly on GitHub)

[1]: http://www.cockos.com/licecap/

And thank you! Your contributions to Snap and its community are always appreciated.
