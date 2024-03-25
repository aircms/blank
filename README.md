# Setup AirCms

## Prerequisites

- Fresh install of Ubuntu 22.04
- User privileges: root or non-root user with sudo privileges
- Install [AirCore environment](https://github.com/aircms/core/blob/main/README.md)
- Install [AirFs environment](https://github.com/aircms/fs/blob/main/README.md)


## Step 1. Install project
### Step 1.1. Clone project sources
```console
cd /var/www
git clone https://github.com/aircms/blank.git
```

### Step 1.2. Install composer dependencies
```console
composer install
```

### Step 1.4. Setup configuration
Based on your environment, open the appropriate file in the ```./config/``` folder and set the following value:

#### Required to edit properties

```admin.title``` - title, will be displayed in the admin panel.

```admin.logo``` - logo, will be displayed near the title.

```admin.auth.root.login``` - super-user login.

```admin.auth.root.password``` - super-user password.

```admin.tiny``` - [Tiny WYSIWYG editor](https://www.tiny.cloud) key, uses in forms.

```storage.url``` - url where storage located.

```storage.key``` - key from AirFs config file.

#### Database
```db``` - database connection settings.

#### Assets
```asset.prefix``` - will add a random hash for js, css etc.

#### Logs
```logs.enabled``` - enable of disable log writing.

```logs.route``` -  admin route for log viewing.

#### Admin

```admin.manage``` - route for admin panel where you can manage admin users.

```admin.history``` - route for viewing admin users action history

```admin.system``` - route for viewing server info.

```admin.fonts``` - route for managing fonts (listing, uploading and etc).

```admin.auth.route``` - route for admin login page.

```admin.auth.cookieName``` - cookie key will be used for storing authority.

```admin.auth.source``` - means is need to authorize users from database.

```admin.menu``` - autogenerated, but can be edited.

## Step 2. Generator

```console
composer run-script gen {fontawesome icon} {type: "multiple" | "single"} {Section} {Name}
```

```fontawesome icon``` - fontawesome icon without ```fa-*``` or ```fas-*```, just icon name.

```type``` - can be ```multiple``` or ```single```

```Section``` - section name for admin menu navigation. For navigation uses ```config/nav.php```.

```Name``` - entity name also for admin menu navigation.

Examples:
```console
composer run-script gen pages single "Home page settings" "Meta settings"
```

```console
Model: true
Controller: true
Config: true
```

After executing this command, a Model, a Controller will be created and an entry will be added to the navigation menu.

```console
Model - app/Model/HomePageSettings.php
Controller - app/Module/Admin/Controller/HomePageSettings.php
``` 
