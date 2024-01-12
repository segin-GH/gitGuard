[![Netlify Status](https://api.netlify.com/api/v1/badges/534b5350-01ca-4019-8003-0d62132d30c2/deploy-status)](https://app.netlify.com/sites/gitguard/deploys)

# gitGuard

### gitguard: where sloppy commits meet their match.



## Overview

`gitGuard` is a versatile, language-agnostic tool designed to enforce commit message standards in various types of projects. Drawing inspiration from `commitlint`, `gitGuard` integrates with version control systems like Git to ensure that all commit messages adhere to predefined rules and standards set by  [convetional commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) .

## Key Features

- **Language Agnosticism**: Compatible with any programming language, ideal for multi-language projects.
- **Easy Integration with Git**: Utilizes Git's `commit-msg` hook for automatic validation of commit messages.
- **Customizable Rules**: Flexible configuration file to define your own commit message rules.
- **Cross-Platform Compatibility**: Works seamlessly on Windows, Linux, and macOS.
- **User-Friendly Feedback**: Provides clear, actionable feedback for non-conforming commit messages.
- **Simple Setup**: Easy to install and configure, fitting into existing workflows effortlessly.

## Installation

1. Clone the `gitGuard` repository:
   ```
   git clone https://github.com/segin-GH/gitGuard.git
   ```
2. Navigate to the `gitGuard` directory:
   ```
   cd gitGuard
   ```
3. Run the installation script (requires appropriate permissions):
   ```
   ./guard.sh
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



