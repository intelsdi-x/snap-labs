This post is an adaptation of what first appeared on  [Medium.com](https://medium.com/@mjbrender/introduction-to-ad-hoc-telemetry-with-snap-and-grafana-d410d71ade5c#.gqmfafi2s).

# Introduction to ad hoc telemetry with Snap and Grafana

![running snap app](https://cloud.githubusercontent.com/assets/1744971/22168317/c3689a74-df20-11e6-9af7-dd5c95b7191b.gif)

Let’s set something up and take a look around. We need Grafana and Snap running at a minimum, so here is the quick way to see the power of the API:

## 1. Install Snap
Remember that OS-specific directions [are always available in the Getting Started section of the project](https://github.com/intelsdi-x/snap#getting-started) (last tested with v1.0.0). I'm on Ubuntu 16.04, so I:
  * `curl` the source file down
  * Install: `sudo apt-get install -y snap-telemetry`
  * Start the service: `systemctl start snap-telemetry`

(Remember, if you're at all confused, review [Getting Started](https://github.com/intelsdi-x/snap#getting-started)).

## 2. Install Grafana
[OS-specific directions are here](http://docs.grafana.org/installation/) (last tested with 4.1.1) . On Ubuntu 16.04:
  * Install stable and its dependences
  * Start the service: `systemctl start grafana-server`

## 3. Download and Load Snap Plugin

Download one or more Snap plugins. The full list is available in the [Plugin Catalog](https://github.com/intelsdi-x/snap/blob/master/docs/PLUGIN_CATALOG.md). We will get psutil in our case. Download the latest release for your OS (last tested in this tutorial is version 9 for Linux):

```
$ sudo apt-get install -y wget
$ wget https://github.com/intelsdi-x/snap-plugin-collector-psutil/releases/download/9/snap-plugin-collector-psutil_linux_x86_64
$ chmod +x snap-plugin-collector-psutil_linux_x86_64
$ snaptel plugin load snap-plugin-collector-psutil_linux_x86_64
```

Snap is running and loaded with the only plugin we need for this example.

## 4. Install Grafana Snap App

Grafana has an app model to extend its functionality. We need the Snap App
([homepage](https://github.com/raintank/snap-app/)|[source](https://github.com/raintank/snap-app)), which is easily installed on the command-line:

```
$ sudo grafana-cli plugins install raintank-snap-app
installing raintank-snap-app @ 0.0.5
from url: https://grafana.net/api/plugins/raintank-snap-app/versions/0.0.5/download
into: /var/lib/grafana/plugins

Failed downloading. Will retry once.
✔ Installed raintank-snap-app successfully

Restart grafana after installing plugins . <service grafana-server restart>
$ systemctl restart grafana-server
```

Now we can [login to Grafana at port 3000](http://127.0.0.1:3000/). 

![configure snap app](https://cloud.githubusercontent.com/assets/1744971/22168319/c38d350a-df20-11e6-8505-99f1659032a9.gif)

From there:

1.  Click the top-left icon and open Plugins
1.  Click the Apps tab, open Snap App, Enable it
1.  From the top-left icon again, go to Data Sources
1.  Add a new data source of type Snap DS pointing to your *snapteld* instance (including port, which is 8181 by default)
1.  Start a new Dashboard with a Graph panel, select Snap DS as the data source
1.  Create the task! Name it, choose an interval and metrics, then start it
1.  Click watch to see live data stream from Snap to the graph just like you would
using *snaptel task watch*

![snap app run](https://cloud.githubusercontent.com/assets/1744971/22168318/c37de276-df20-11e6-9378-7ec5bf30e608.gif)

By taking these steps, you configured a task in Snap all through the API.