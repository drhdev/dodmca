# dodmca

The `dodmca.sh` script automates the process of logging into an email account via IMAP, scanning for specific emails that match predefined criteria, and performing actions based on those criteria. Specifically designed to handle DMCA notices, security alerts, and abuse reports from DigitalOcean, this script filters emails for certain keywords in the sender address, subject, and body of the email. When a matching email is found, the script creates a text file with details of the email and offers the option to notify a user via Telegram.

## Features

- IMAP email login and processing
- Filtering emails based on sender, subject, and body content
- Creation of detailed log files for matching emails
- Optional Telegram notifications
- Configuration of IMAP server, port, and credentials
- Customizable search keywords and logic
- Management of log file size and verbosity

## Prerequisites

Before you install and run the `dodmca.sh` script, ensure you have the following prerequisites installed on your system:

- `mutt` or a similar utility for handling email content
- `mailutils` for email processing
- An IMAP server and credentials for accessing the email account

## Installation

1. Clone the repository to your local machine:

```bash
git clone https://github.com/drhdev/dodmca.git
```

2. Navigate to the `dodmca` directory:

```bash
cd dodmca
```

3. Make the script executable:

```bash
chmod +x dodmca.sh
```

4. (Optional) If you intend to use the Telegram notification feature, ensure `totelgram.sh` is also in the directory and executable.

## Usage

To run the `dodmca.sh` script, use the following command:

```bash
./dodmca.sh [options]
```

### Options

The script supports several options for customization:

- `-e` Email address to check
- `-s` IMAP server
- `-p` IMAP port
- `-w` Password for IMAP login
- `-k` Keywords to search in the sender's email address
- `-l` Keywords to search in the email subject
- `-m` Keywords to search in the email body
- `-n` Enable/disable sending to Telegram (on/off)
- `-o` Path to store the text files
- `-q` Maximum number of text files to keep
- `-r` Path for the log file
- `-t` Output verbosity (verbose/silent)

For detailed descriptions of each option, refer to the script's inline documentation.

## Contributing

Contributions are welcome! If you have suggestions for improvements or bug fixes, please open an issue or submit a pull request.

## License

This project is licensed under the GNU Public License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Special thanks to the DigitalOcean community for inspiring this project.
- Thank you to all contributors and users of this script.

For more information, issues, and feature requests, please visit the [repository issues page](https://github.com/drhdev/dodmca/issues).
