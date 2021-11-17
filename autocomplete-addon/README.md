# Autocomplete Add-On for Projects Endings staticSearch

The Add-On was created to add an autocomplete function for https://github.com/projectEndings/staticSearch. Prior to running the following steps staticSearch must be installed according to their documentation.

## Required package

For fetching files and download data the openFile function of package https://github.com/acdh-oeaw/arche_api is required.
Please install the package prior to setup. 

## Getting started

Download and unzip or clone the repository to your project directory.

Customize the config.txt with line break seperated text.

1. Project Name default "anyname"
2. Main directory name where your project default "html"
3. Filepath to staticSearch output directory default "static-search"
4. Directory name where stems json files are stored by staticSearch default "stems"
5. End of document default "-----" please do not change

Example (do not add quotation marks in your txt):

```javascript
anyname
html
static-search
stems
-----
```

Run script.sh in your terminal. Attention! If your main project directory is not called "html" you have to adapt script.sh to the correct directory name.

## Javascript files

autocomplete.js must be added as script link to your HTML search page.
autocomplete-download-only.js can be placed at any HTML page except the search page as script link. 
The latter is used to reduce loading time for users.

## CSS

style.css holds some style proposals (optional)
