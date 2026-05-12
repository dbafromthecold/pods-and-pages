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

## Session Aim
<!-- .slide: style="text-align: left;"> -->

To explore how databases can be deployed and operated in Kubernetes.<br>
<br>
We'll look at the core DBA responsibilities of availability, recoverability, and performance.

## Agenda
<!-- .slide: style="text-align: left;"> -->

- Why run databases in Kubernetes?
- Getting up and running
- Day 2 operations

---

# Why databases in Kubernetes?
<!-- .slide: style="text-align: left;"> -->

---

<p align="center">
<img src="images/containers-qa-refresh.png" />
</p>

<font size="6">
<a href="https://www.sqlservercentral.com/articles/ding-the-world%E2%80%99s-largest-mobile-top-up-network-streamlines-qa-with-sql-server-containers ">Streamlining QA with SQL Server Containers</a><br>
</font>

---

## Streamlining QA
<!-- .slide: style="text-align: left;"> -->
- Current QA process refreshed VMs monthly
- Each refresh required installing SQL Server
- Process took over 45 minutes for each VM
<br>
<span class="fragment fade-in" data-fragment-index="2">
New procees utilising containers took no more than 2 minutes
</span>

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
No! We care about the <b><i>DATA</i></b>
</span>

---

# Getting up and running
<!-- .slide: style="text-align: left;"> -->

---

## Deploying to Kubernetes
<!-- .slide: style="text-align: left;"> -->

Use StatefulSets rather than Deployments for databases
<br>
<ul>
<li class="fragment">Built for stateful applications</li>
<li class="fragment">Stable pod identity and storage</li>
<li class="fragment">Ordered creation and termination</li>
<li class="fragment">Persistent storage is uniquely assigned per replica</li>
</ul>

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

## Secrets
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

## Services
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

# Availability
<!-- .slide: style="text-align: left;"> -->

---

## One replica?
<!-- .slide: style="text-align: left;"> -->
TBD

---

## Probes
<!-- .slide: style="text-align: left;"> -->
TBD

---

## Tolerations
<!-- .slide: style="text-align: left;"> -->
TBD

---

# Recoverability
<!-- .slide: style="text-align: left;"> -->

---

## Reclaim policies
<!-- .slide: style="text-align: left;"> -->
## Reclaim policies
<!-- .slide: style="text-align: left;"> -->

What happens to the volume when the claim is deleted?
<br>
<ul>
<li class="fragment" data-fragment-index="1">Delete: remove the underlying storage</li>
<li class="fragment" data-fragment-index="2">Retain: keep the underlying storage</li>
</ul>
<br>
<span class="fragment fade-in" data-fragment-index="3">
That setting can be the difference between recovery and a very quiet room
</span>

---

# Performance
<!-- .slide: style="text-align: left;"> -->

---

# Chaos Engineering
<!-- .slide: style="text-align: left;"> -->

---

### What is Chaos Engineering?
<!-- .slide: style="text-align: left;"> -->
"Chaos Engineering is the discipline of experimenting on a system in order to build confidence in the system's capability to withstand turbulent conditions in production"<br>
<font size="6"><a href="principlesofchaos.org">principlesofchaos.org</a></font>

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
