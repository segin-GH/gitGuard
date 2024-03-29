[![Netlify Status](https://api.netlify.com/api/v1/badges/534b5350-01ca-4019-8003-0d62132d30c2/deploy-status)](https://app.netlify.com/sites/gitguard/deploys)  [![build](https://github.com/segin-GH/gitGuard/actions/workflows/zip-src.yml/badge.svg?branch=main)](https://github.com/segin-GH/gitGuard/actions/workflows/zip-src.yml)

# gitGuard

### gitguard: where sloppy commits meet their match.

![example](https://github.com/segin-GH/gitGuard/assets/98380527/3905b2f7-faa4-4988-99a4-a055c1a0eaab)


## Overview

`gitGuard` is a versatile, language-agnostic tool designed to enforce commit message standards in various types of projects. Drawing inspiration from `commitlint`, `gitGuard` integrates with version control systems like Git to ensure that all commit messages adhere to predefined rules and standards set by  [convetional commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) .

## Setup
1. Download Git-Guard in root of the repo
	```
	wget https://github.com/segin-GH/gitGuard/raw/main/dist/gitguard.zip
	```
2.  unzip `gitguard.zip`
	```
	unzip gitguard.zip 
	```
3.  rm `gitguard.zip`
	```
	rm gitguard.zip
	``` 
4. Install `gitguard`
	```
	./gitguard.py
	```

## Key Features

- **Language Agnosticism**: Compatible with any programming language, ideal for multi-language projects.
- **Easy Integration with Git**: Utilizes Git's `commit-msg` hook for automatic validation of commit messages.
- **Customizable Rules**: Flexible configuration file to define your own commit message rules. (not implemnted)
- **Cross-Platform Compatibility**: Works seamlessly on Windows, Linux, and macOS. (Only tested in LINUX)
- **User-Friendly Feedback**: Provides clear, actionable feedback for non-conforming commit messages.
- **Simple Setup**: Easy to install and configure, fitting into existing workflows effortlessly.

## Installation (DEV)

1. Clone the `gitGuard` repository:
   ```
   git clone https://github.com/segin-GH/gitGuard.git
   ```
2. Navigate to the `gitGuard` directory:
   ```
   cd ./gitGuard/src
   ```
3. Run the installation script (requires appropriate permissions):
   ```
   ./gitguard.py
   ```

## Configuration

After installation, create a `.gitguardrc` file in your project's root directory. This file is used to configure your commit message rules. An example configuration:

```json
{
  still not defined
}
```

## Usage

Once `gitGuard` is installed and configured, it automatically validates commit messages according to the rules specified in your `.gitguardrc` file. If a commit message does not conform to these rules, `gitGuard` will reject the commit and provide feedback for necessary corrections.

## Contributing

We welcome contributions to `gitGuard`! Please read our contributing guidelines in `CONTRIBUTING.md` for more information on how you can contribute to this project.


