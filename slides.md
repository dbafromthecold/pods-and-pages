  # Pods and Pages
## Databases in Kubernetes

---

## Andrew Pruski

<img src="images/apruski.jpg" style="float: right"/>

### Field Solutions Architect
#### Microsoft Data Platform MVP 
#### Docker Captain
#### VMware vExpert

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

## The three main responsibilities
<!-- .slide: style="text-align: left;"> -->
- Availability
- Recoverability
- Performance

---

# Availability
<!-- .slide: style="text-align: left;"> -->

---

---

<img src="images/kubeinvaders.gif" style="float: center"/>

---

## Key takeaways
<!-- .slide: style="text-align: left;"> -->
- Kubernetes gives us powerful primitives
- Databases still need database thinking
- Persistence is not backup
- Placement is an availability and performance decision
- Operators encode operational knowledge
- Failure testing proves the design

---

## Resources
<!-- .slide: style="text-align: left;"> -->
<font size="6">
<a href="https://github.com/dbafromthecold/pods-and-pages">https://github.com/dbafromthecold/pods-and-pages</a><br>
</font>

<p align="center">
<img src="images/pods-and-pages-qr.png" />
</p>
