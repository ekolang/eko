
<img src="eko.jpg" height="100" width="100"/>
</center>

## Quick Install (Linux/macOS)

```bash
curl -sL https://raw.githubusercontent.com/ekolang/eko/main/install.sh | bash
```

<h1 style="font-weight:bold;"> Eko Programming Language</h1>

<h1 style="font-weight:bold;">Why Eko?</h1>
We all love C, but at the same time, it's difficult to use in projects and working with pointers makes many people die when writing it. But the goal of Eko is almost the same. Basically, Eko wants to have a simple and functional syntax like Turbo C, easy to understand and work with, but in a modern environment.
<h1>Current status</h1>
well, right now the project is in alpha mode. That means it's only released for debugging and it's full of bugs! And it's fixing problems and testing new features. So it's not suitable for use and it's not predictable to some extent. And it's more educational than industrial.
<h1>Examples</h1>
EKo is easy and really human-friendly. It's very easy to read and it depends on how well or how busy you are at coding.
<p>print hello world ``helloworld.eko``</p>
<pre><code>
generate main() {
  write("Hello World!\n");
}
</pre></code>
<p>print hello world with escapes and add to string to themself ``helloworlde.eko``</p>
<pre><code>
generate main() {
  // s0 is a escape for space
  // you can remove return if you want normal exit-code.
  write("Hello" + "\s0" + "World\n");
  return 0;
}
</pre></code>
<p>get input from user and check if it equal to a value ``checkinput.eko``</p>
<pre><code>
generate char -v:content[] = getInput().chomp

generate main() {
    if (strcmp("ekolang", -v:content)):
        write("Hello ekolang!\n");
        end;
}
</pre></code>
<p>create a function (give arguments is not support for now) ``func.eko``</p>
<pre><code>
generate Printer() {
	write("Hello");
}

generate main() {
	Printer();
}
</code></pre>
<p>create a loop to print from zero to 12 ``loop.eko``</p>
<pre><code>
generate int -v:count = 0

generate print() {
	-v:count = -v:count++
	write(-v:count + "\n");
	test();
}

generate test() {
	if (-v:count > 11):
		write("Job is Done");
		end;
	else: print();
}

generate main() {
	test();
}

</code></pre>
More example in (examples/)
if you want learn Eko fully, you can go to <a href="https://ekolang.github.io/eko">Here.</a>


# Compile it yourself
To compile, you need to have the following prerequisites:
```DMD - Dub - bin - handy-httpd - marschiert (runtime) - dgfx - arsd-offical:simpledisplay```
Dub dependencies are automatically downloaded during compilation and do not need to be installed from the beginning.
<a href="https://dlang.org/download.html">DMD Download Page</a>
(dub will install auto with DMD)

after download and install dmd in your system, clone repository with ```git```:
```git clone https://github.com/ekolang/eko```
after that, open ```eko``` folder with ```cd eko```
and go to ```runtime```
You have to first compile runtime library, them put it in a global-library folder then linux and linker can found it. for example, you can put it in ```/usr/local/lib```.
after putting library in ```/usr/local/lib``` go back and in ```src```, run ```dub```.

Also, you can change ```dub.json``` to build ```eko``` as release not debug. (lower-binery size.)
now, try it with ```./eko --version``` and enjoy.
