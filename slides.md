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
TBD

---

## Agenda
<!-- .slide: style="text-align: left;"> -->
TBD

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
TBD

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
No! We care about the DATA
</span>

---

## Containers are not magic
<!-- .slide: style="text-align: left;"> -->
<ul>
<li class="fragment">The database still needs CPU, memory, storage, and network</li>
<li class="fragment">The transaction log still matters</li>
<li class="fragment">The backup strategy still matters</li>
<li class="fragment">The failure modes are different, not gone</li>
</ul>

---

# Getting up and running
<!-- .slide: style="text-align: left;"> -->

---

## Deploying to Kubernetes
<!-- .slide: style="text-align: left;"> -->
TBD

---

## Kubernetes Storage
<!-- .slide: style="text-align: left;"> -->

<div style="display: flex; align-items: center;">
<div style="width: 35%;">

<img src="images/kubernetes-storage.png" style="border: 0; background: none; box-shadow: none;" />

</div>
<div style="width: 65%; padding-left: 40px;">

<ul>
<li class="fragment">StatefulSets reference PersistentVolumeClaims</li>
<li class="fragment">PersistentVolumeClaims map to PersistentVolumes</li>
<li class="fragment">PersistentVolumes are provisioned from a StorageClass</li>
<li class="fragment">Storage persists independently from the pod lifecycle</li>
</ul>

</div>
</div>

---

## StorageClasses
<!-- .slide: style="text-align: left;"> -->
StorageClasses describe types of storage
<br>
<br>
<ul>
<li class="fragment">Fast local disk</li>
<li class="fragment">Network block storage</li>
<li class="fragment">Premium or standard tiers</li>
<li class="fragment">Encryption and replication options</li>
<li class="fragment">Volume expansion support</li>
</ul>

---

## PersistentVolumes
<!-- .slide: style="text-align: left;"> -->
A PersistentVolume is storage made available to the cluster
<br>
<br>
<ul>
<li class="fragment">Provisioned manually or dynamically</li>
<li class="fragment">Backed by a storage provider</li>
<li class="fragment">Mounted into a pod</li>
<li class="fragment">Independent from pod lifecycle</li>
</ul>

---

## PersistentVolumeClaims
<!-- .slide: style="text-align: left;"> -->
A PersistentVolumeClaim is a request for storage
<br>
<br>
<pre><code>resources:
  requests:
    storage: 500Gi</code></pre>
<br>
<span class="fragment fade-in" data-fragment-index="1">
For StatefulSets, each replica usually gets its own claim
</span>

---

## Reclaim policies
<!-- .slide: style="text-align: left;"> -->
What happens to the volume when the claim is deleted?
<br>
<br>
<ul>
<li class="fragment">Delete: remove the underlying storage</li>
<li class="fragment">Retain: keep the underlying storage</li>
</ul>
<br>
<span class="fragment fade-in" data-fragment-index="3">
That setting can be the difference between recovery and a very quiet room
</span>

---

## StatefulSets
<!-- .slide: style="text-align: left;"> -->
TBD

---

## Secrets
<!-- .slide: style="text-align: left;"> -->
TBD

---

## Services
<!-- .slide: style="text-align: left;"> -->
TBD

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

# Recoverability
<!-- .slide: style="text-align: left;"> -->

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
