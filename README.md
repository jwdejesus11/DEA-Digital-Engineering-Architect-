# DEA Information Modeling

DEA Information Modeling is a Papyrus-based modeling product that is customized and streamlined for users interested in modeling the static structure of information with UML class diagrams. For more information, please also confer the [Eclipse Wiki](https://wiki.eclipse.org/Papyrus_for_Information_Modeling). This read-me file rather addresses developers and contributors.

## Building the product

When downloading the repository you must enable git long path access:

```
git config --system core.longpaths true
```

In order to run the build of this application you need to have [Apache Maven](https://maven.apache.org/) installed and configured.

### Downloading the dependencies to run the application

@@[jdk-8u202-windows-x64.exe]
or
@@[jdk-8u202-windows-i586.exe] (x86 version)

through this official link of [Oracle](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)

### Building the product on your machine

To perform the dynamic installation, the [install.bat] file must be executed in the branch of the project

Once all the internal build process is done, the application is packaged in several zips for different systems and under this path:

[\releng\org.eclipse.papyrus.information.modeling.product\target\products]()(From root)

Together with the install.bat unzip the x64 version in the DEA folder in the path described above,
for the x32 version only unzip the one ending in [win32.x86].

To also build the modules relative to RCP and Product, please activate the following profile:

```
mvn clean install -Pproduct
```
