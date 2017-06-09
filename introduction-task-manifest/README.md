*This post is an adaptation of what first appeared on [Medium.com here](https://medium.com/intel-sdi/the-guts-of-tasks-how-snap-runs-8c5d2405ea61).*

# The Guts of Tasks: How Snap Gathers Telemetry

My [last post](https://medium.com/intel-sdi/my-how-to-for-the-snap-telemetry-framework-e3bb641bc740) dug into the how-to of running Snap. The steps are worth outlining as we continue to get familiar with the project:

![](https://cdn-images-1.medium.com/max/1200/1*h6ybssckrbVHxI56tesSiA.png)
<span class="figcaption_hack">Snappy The Telemetry Snapping Turtle</span>

* Download a Snap release (latest is [now
v1.2](https://github.com/intelsdi-x/snap/releases))
* Start *snapteld*, the Snap daemon
* Use *snaptel* to load any plugins and create a task from the [examples
folder](https://github.com/intelsdi-x/snap/tree/master/examples)
* Watch the running task

That’s the flow: download, run the daemon, load plugins and create a task. All
operational tutorials of the project go through this flow.

Now that you’re familiar with it, let’s dive into the guts.

How do I customize the telemetry I gather? How do I decide where to publish it?
At what time interval?

The answer to each of these is in a **Task Manifest**.

### Anatomy of a Task Manifest

A **Task** describes the how, what, and when for a Snap job and this information
is expressed in a **Task Manifest**. Here’s a commented version, written in
YAML, to learn by example:

```
--- # The Header starts after this line
  version: 1          # Snap API version
  schedule:           # How frequently should we run this task?
    type: "simple"    # Simple means run forever at the interval below
    interval: "1s"    # This accepts seconds, milliseconds, days and more
  workflow:           # Note that collector caching defaults to 500ms
    collect:          
      metrics:        # Here are the specific metrics we collect out of the set
        /intel/psutil/load/load1: {}     # of all available from those loaded.
        /intel/psutil/load/load15: {}    # This list only requires psutil but
        /intel/psutil/load/load5: {}     # could include others.
      publish:        # Here is where we will publish the metrics.             
        -             # We skipped on having a "processor" plugin here.
          plugin_name: "file"            # Name of the publisher plugin.
          config:                        # Required configuration options.
            file: "/tmp/snap_published_demo_file.log"
```

You can see the header comes with some powerful options to define your own interval and type of collection. Most users start with the simple scheduler, but you can [dig deeper into options for schedules here](https://github.com/intelsdi-x/snap/blob/8179d772257ad9c169f962650e4407da04c4ccf7/docs/TASKS.md#schedule). After the header, you get to the important parts: 
* `collect` is what you want to gather (and implies a list of required plugins)
* `publish` is where you want to store the results (also a requirement)

There are also implied permission levels here. For example, for the file publisher to write to `/tmp/snap_published_demo_file.log`, `snapteld` must be running as a user who *can* write to that file. Be sure to read up on requirements on a plugin to plugin basis.

### How I Write Task Manifest

Here’s my flow for authoring a new **Task Manifest**:

1: Copy/paste an existing, valid task like the YAML above

2: Start *snapteld* and load any collector plugins you would like to collect:

    $ snapteld -t 0

    # In another window:
    $ snaptel plugin load $PATH_TO/snap-plugin-collector-psutil

    # And so on for each plugin you load, then:
    $ snaptel metric list | cut -f 1

3: Copy/paste the metrics listed after *cut* and put them into the metrics
section as show in our example above.

4: Meet the formatting requirements for each metric listed, appending
“: {}” to the end of each line as shown (FYI, these are used to pin versions of plugins in the Task Manifest. That's a more advanced topic).

*Recommendation*: Use shortcuts from your favorite IDE to make the formatting painless. I use [Atom](https://atom.io/) these days and multi-select lines using the [Sublime-Style-Column-Selection](https://atom.io/packages/Sublime-Style-Column-Selection) plugin (which you can also do in Sublime Text 3, as the name suggests).

5: Save and load your new Task Manifest using `snaptel task create -t
my-task.yaml`

*Note*: As of today, if you want to use the REST API directly through cURL or otherwise, you’ll need to convert the YAML to JSON. I use the *json2yaml* Python utility, which I installed using *pip* (`pip install json2yaml`).

Here’s a video of another example of writing a Task Manifest to bring this home: https://vimeo.com/163308828

### But, Why?

Why have a separation between what you *could* collect and what you are
*collecting*?

The videos give walkthroughs of how, so I’ll focus in on the **why**.

An important design decision for Snap came in the division between available metrics and collected metrics. Since Tasks often include multiple collectors, there’s a lot of valuable details available, but it can be overwhelming to see them all at once. For instance, the [psutil](https://github.com/intelsdi-x/snap-plugin-collector-psutil) plugin gathers 41 values. Add in a powerful Intel-specific plugin like [PCM](https://github.com/intelsdi-x/snap-plugin-collector-pcm) (Intel Performance Counter Monitor) and you have another 29. We could gather all of these measurements, then include a few more from [ethtool](https://github.com/intelsdi-x/snap-plugin-collector-ethtool), [docker](https://github.com/intelsdi-x/snap-plugin-collector-docker) and [etcd](https://github.com/intelsdi-x/snap-plugin-collector-etcd), but we soon have hundreds of measurements.

Tasks define which metrics will be collected allowing us to be precise in
choosing exactly what information we want streaming through *snapteld*. This gets
particularly important when you look at a plugin like ethtool, which can gather
hundreds of network measurements per physical device. Focusing in on meaningful
information reduces our noise AND our resource utilization.

### Tasks as a Powerful Abstraction

Tasks are powerful in how they decouple important details of measurement. Each
Task can manage its own workflow of telemetry. Each Task can run on its own
schedule. All metrics listed in tasks allow for the pinning of versions of
plugins as needed. These decouplings allow for the flexible collection of data
while keeping resource use light and administration operationally simple. It’s a
tough dichotomy to balance — simplicity and effectiveness — but I think Snap is
dead on target.

I’d enjoy seeing your first Task Manifest. Be sure to share your gists or GitHub
repos in [our Slack channel!](https://snap.snap-telemetry.io)
