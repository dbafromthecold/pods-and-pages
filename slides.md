# Pods and Pages
## Databases in Kubernetes

---

## Andrew Pruski

<img src="images/apruski.jpg" style="float: right"/>

### Principal Field Solutions Architect
#### Microsoft Data Platform MVP 
#### Docker Captain
#### Redgate Ambassador

<!-- .slide: style="text-align: left;"> -->
<i class="fa-brands fa-bluesky"></i><a href="https://bsky.app/profile/dbafromthecold.com">  @dbafromthecold.com</a><br>
<i class="fas fa-envelope"></i>  dbafromthecold@gmail.com<br>
<i class="fab fa-wordpress"></i>  www.dbafromthecold.com<br>
<i class="fab fa-github"></i><a href="https://github.com/dbafromthecold">  github.com/dbafromthecold</a>

---

### Session Aim
<!-- .slide: style="text-align: left;"> -->

To explore how databases can be deployed and operated in Kubernetes. We'll look at the core DBA responsibilities of availability, recoverability, and performance.

### Agenda
<!-- .slide: style="text-align: left;"> -->

- Why run databases in Kubernetes?
- Getting up and running
- Day 2 operations

---

### Why databases in Kubernetes?
<!-- .slide: style="text-align: left;"> -->

<div style="text-align:center;">
    <img src="https://media.tenor.com/7zKzuI4IEfAAAAAC/but-why.gif">
</div>

---

## A change of mindset
<!-- .slide: style="text-align: left;"> -->
Containers change how we think about databases...
<br>
<br>
<span class="fragment fade-in" data-fragment-index="1">
Do we care about the compute?....really?
</span>
<br>
<br>
<span class="fragment fade-in" data-fragment-index="2">
No! We care about the <b><em>DATA</em></b>
</span>

---

<p align="center">
<img src="images/containers-qa-refresh.png" />
</p>

<div style="text-align: left; font-size: 0.8em;">
<a href="https://www.sqlservercentral.com/articles/ding-the-world%E2%80%99s-largest-mobile-top-up-network-streamlines-qa-with-sql-server-containers">
https://www.sqlservercentral.com/articles/ding-the-world%E2%80%99s-largest-mobile-top-up-network-streamlines-qa-with-sql-server-containers
</a>
</div>

---

## Streamlining QA
<!-- .slide: style="text-align: left;"> -->
- Current QA process refreshed VMs monthly
- Each refresh required installing SQL Server
- Process took over 45 minutes for each VM
<br>
<br>
<span class="fragment fade-in" data-fragment-index="2">
- New process utilising containers took no more than 2 minutes
</span>

---

# Getting up and running
<!-- .slide: style="text-align: left;"> -->

---

## Deploying to Kubernetes
<!-- .slide: style="text-align: left;"> -->

Use StatefulSets rather than Deployments
<br>
- Built for stateful applications
- Stable pod identity and storage
- Ordered creation and termination
- Persistent storage is uniquely assigned per replica

---

## Kubernetes Storage
<!-- .slide: style="text-align: left;"> -->

<div style="display: flex; align-items: center;">
<div style="width: 70%; padding-right: 40px; font-size: 0.9em;">
<ul>
<li class="fragment">StatefulSets reference PersistentVolumeClaims</li>
<li class="fragment">PersistentVolumeClaims bind to PersistentVolumes</li>
<li class="fragment">StorageClasses describe types of storage</li>
<li class="fragment">Storage persists independently from the pod lifecycle</li>
</ul>
</div>
<div style="width: 30%; text-align: center;">
<img src="images/kubernetes_storage.png" style="border: 0; background: none; box-shadow: none; max-height: 500px;" />
</div>
</div>

---

### Secrets
<!-- .slide: style="text-align: left;"> -->

<div style="display: flex; align-items: center;">
<div style="width: 30%; text-align: center;">
<img src="images/secret-128.png"
     style="border: 0; background: none; box-shadow: none; max-height: 500px;" />
</div>
<div style="width: 70%; padding-left: 40px; font-size: 0.9em;">
<ul>
<li class="fragment">Don't put sensitive information in StatefulSet manifests!</li>
<li class="fragment">Use Secrets to store usernames and passwords</li>
<li class="fragment">Secrets are encoded, not encrypted</li>
</ul>
</div>
</div>

### Services
<!-- .slide: style="text-align: left;"> -->
<div style="display: flex; align-items: center;">
<div style="width: 70%; padding-right: 40px; font-size: 0.9em;">
<ul>
<li class="fragment">Where are we connecting from?</li>
<li class="fragment">Services provide stable network endpoints</li>
<li class="fragment">Is outside access required?</li>
</ul>
</div>
<div style="width: 30%; text-align: center;">
<img src="images/svc-128.png" style="border: 0; background: none; box-shadow: none; max-height: 500px;" />
</div>
</div>

---

## The three main responsibilities
<!-- .slide: style="text-align: left;"> -->
- Availability
- Recoverability
- Performance

---

### Availability
<!-- .slide: style="text-align: left;"> -->

<div style="text-align:center;">
    <img src="https://tenor.com/view/whatever-you-need-me-to-do-im-available-whatever-i-can-do-robert-de-niro-irishman-gif-16206126">
</div>

---

## One replica?
<!-- .slide: style="text-align: left;"> -->

Deploying a single replica means relying on Kubernetes for recovery rather than database high availability<br>
Operators can provide database-level high availability capabilities such as:
<ul>
<li class="fragment">Replication</li>
<li class="fragment">Automatic failover</li>
<li class="fragment">Backup and recovery automation</li>
</ul>
<br>
<br>
<span class="fragment fade-in">
However, operators also introduce additional operational complexity
</span>

---

## Probes
<!-- .slide: style="text-align: left;"> -->

<ul>
<li class="fragment">Startup probe</li>
    <ul>
        <li class="fragment">Is SQL Server still starting?</li>
    </ul>
<li class="fragment">Readiness probe</li>
    <ul>
        <li class="fragment">Can we accept connections?</li>
    </ul>
<li class="fragment">Liveness probe</li>
    <ul>
        <li class="fragment">Should Kubernetes restart the container?</li>
        <li class="fragment">A bad liveness probe can become a self-inflicted outage!</li>
    </ul>
</ul>

---

## Tolerations
<!-- .slide: style="text-align: left;"> -->

How long should a database pod remain on an unhealthy node
before Kubernetes evicts it?
<br>
<br>
<pre><code data-line-numbers="*|2-5|6-9">tolerations:
- key: "node.kubernetes.io/unreachable"
  operator: "Exists"
  effect: "NoExecute"
  tolerationSeconds: 10
- key: "node.kubernetes.io/not-ready"
  operator: "Exists"
  effect: "NoExecute"
  tolerationSeconds: 10
</pre></code>

---

### Recoverability
<!-- .slide: style="text-align: left;"> -->

<div style="text-align:center;">
    <img src="https://tenor.com/view/fast-recovery-speedy-quick-gif-23662662">
</div>

---

## Backups
<!-- .slide: style="text-align: left;"> -->

Remember...Kubernetes is just another platform

- Still take your backups!<br>
- Get those backups out of the cluster asap<br>
- Regular restore testing is critical<br>

---

## Volume Snapshots
<!-- .slide: style="text-align: left;"> -->

What type of snapshot are we talking about?
<br><br>

<ul>
  <li>Crash-consistent snapshots</li>
  <li>Application-consistent snapshots</li>
</ul>

<br>

<div class="fragment fade-in">
  Only application-consistent snapshots should be considered a replacement for native database backups
</div>

<br>

<div class="fragment fade-in">
  How portable are those snapshots between storage platforms or clusters?
</div>

---

## Volume Reclaim policies
<!-- .slide: style="text-align: left;"> -->

What happens to the volume when the claim is deleted?
<br>
<ul>
<li class="fragment" data-fragment-index="1">Delete: remove the underlying storage</li>
<li class="fragment" data-fragment-index="2">Retain: keep the underlying storage</li>
</ul>
<br>
<br>
<span class="fragment fade-in" data-fragment-index="3">
That setting can be the difference between recovery and </b><em>a very quiet room</em></b>
</span>

---

### Performance
<!-- .slide: style="text-align: left;"> -->

<div style="text-align:center;">
    <img src="https://tenor.com/view/speed-gif-5593954">
</div>

---

## Storage
<!-- .slide: style="text-align: left;"> -->

- Go for the fastest storage available to the cluster<br>
- Follow best practices for database file layout<br>
- Use snapshots to complement database backups<br>
- Test storage performance with realistic database workloads

---

## Requests and Limits
<!-- .slide: style="text-align: left;" -->

The noisy neighbour problem!
<br><br>

Set CPU and Memory limits
<br>

Be aware of database quirks!
<br><br>

Kubernetes assigns Quality of Service based on requests and limits

<ul>
  <li class="fragment" data-fragment-index="1">Guaranteed</li>
  <li class="fragment" data-fragment-index="2">Burstable</li>
  <li class="fragment" data-fragment-index="3">BestEffort</li>
</ul>

<br>

<div class="fragment fade-in" data-fragment-index="4">
  Databases generally should <em>not</em> be BestEffort
</div>

---

## Tools for testing performance
<!-- .slide: style="text-align: left;"> -->

- Don't only use synthetic tools for testing<br>
- Ideally replay production workloads<br>
- Or use tools that drive known benchmarks<br>
- Utilise database engine tooling to analyse workloads<br>

---

### Chaos Engineering
<!-- .slide: style="text-align: left;"> -->

<p align="center">
<img src="images/chaos.gif"/>
</p>

---

### What is Chaos Engineering?
<!-- .slide: style="text-align: left;"> -->
"Chaos Engineering is the discipline of experimenting on a system in order to build confidence in the system's capability to withstand turbulent conditions in production"<br>
<font size="6"><a href="principlesofchaos.org">principlesofchaos.org</a></font>

---

## Recent Failure experiments
<!-- .slide: style="text-align: left;"> -->

- Recent testing of an AG operator for SQL Server
<ul>
<li class="fragment">Pod failure</li>
<li class="fragment">Node failure</li>
<li class="fragment">Service interruption</li>
<li class="fragment">Storage Failure</li>
</ul>

---

<img src="images/kubeinvaders.gif" style="float: center"/>

---

## Resources
<!-- .slide: style="text-align: left;"> -->
<font size="6">
<a href="https://github.com/dbafromthecold/pods-and-pages">https://github.com/dbafromthecold/pods-and-pages</a><br>
</font>

<p align="center">
<img src="images/pods-and-pages-qr.png" />
</p>
