# MyLFS
It's a giant bash script that builds Linux From Scratch.

Pronounce it in whatever way seems best to you.

If you don't know what this is, or haven't built Linux From Scratch on your own before, you should go through the [LFS book](https://linuxfromscratch.org) before using this script.

## How To Use
Basically, just run `sudo ./build.sh` and then stare at your terminal for several hours. Maybe meditate on life or something while you wait. Or maybe clean your room or do your dishes finally. I don't know. Do whatever you want. Maybe by the end of the script, you'll realize why you love linux so much: you love it because it is *hard*. Just like going to the moon, god dammit.

```
$ sudo ./build.sh --help

Welcome to MyLFS.

    WARNING: Most of the functionality in this script requires root privilages,
and involves the partitioning, mounting and unmounting of device files. Use at
your own risk.

    If you would like to build Linux From Scratch from beginning to end, just
run the script with the '--build-all' command. Otherwise, you can build LFS one step
at a time by using the various commands outlined below. Before building anything
however, you should be sure to run the script with '--check' to verify the
dependencies on your system. If you want to install the IMG file that this
script produces onto a storage device, you can specify '--install /dev/<devname>'
on the commandline. Be careful with that last one - it WILL destroy all partitions
on the device you specify.

    options:
        -v|--version        Print the LFS version this build is based on, then exit.
        
        -V|--verbose        The script will output more information where applicable
                            (careful what you wish for).
                            
        -e|--check          Output LFS dependency version information, then exit.
                            It is recommended that you run this before proceeding
                            with the rest of the build.
                            
        -b|--build-all      Run the entire script from beginning to end.
        
        -d|--download-pkgs  Download all packages into the 'pkgs' directory, then
                            exit.
                            
        -i|--init           Create the .img file, partition it, setup basic directory
                            structure, then exit.
                            
        -p|--start-phase
        -a|--start-package  Select a phase and optionally a package
                            within that phase to start building from.
                            These options are only available if the preceeding
                            phases have been completed. They should really only
                            be used when something broke during a build, and you
                            don't want to start from the beginning again.
                            
        -o|--one-off        Only build the specified phase/package.
        
        -k|--kernel-config  Optional path to kernel config file to use during linux
                            build.
                            
        -m|--mount
        -u|--umount         These options will mount or unmount the disk image to the
                            filesystem, and then exit the script immediately.
                            You should be sure to unmount prior to running any part of
                            the build, since the image will be automatically mounted
                            and then unmounted at the end.
                            
        -n|--install        Specify the path to a block device on which to install the
                            fully built img file.
                            
        -c|--clean          This will unmount and delete the image, and clear the
                            logs.
                            
        -h|--help           Show this message.
```

## How It Works

The script builds LFS by completing the following steps:

### Step 1.
Create a 10 gigabyte IMG file called `lfs.img`. This will serve as a virtual hard drive on which to build LFS.

### Step 2.
"Attach" the IMG file as a loop device using `losetup`. This way, the host machine can operate on the IMG file as if it were a physical storage device.

### Step 3.
Partition the IMG file via the loop device we've created, put an ext4 filesystem on it, then add a basic directory structure and some config files (such as /boot/grub/grub.cfg etc).

### Step 4.
Build initial cross compilation tools. This corresponds to chapter 5 in the LFS book.

### Step 5.
Begin to build tools required for minimal chroot environment. (chapter 6)

### Step 6.
Enter chroot environment, and build remaing tools needed to build the entire LFS system. (chapter 7)

### Step 7.
Build the entire LFS system from within chroot envirnment, including the kernel, GRUB, and others.

### That's all.
If at any point over the course of the build something breaks, you can examine the build logs in the aptly named `logs` directory. If you discover the source of the breakage and manage to fix it, you can start the script up again from where you left off using the `--start-phase <phase-number>` and `--start-package <package-name>` commands. You *might* be able to boot up the IMG file in a virtual machine, but I have just been using a flash drive and my laptop. If you want to install the finished product onto a storage device (such as a flash drive as I have been doing), checkout the `--install` command.
