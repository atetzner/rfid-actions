# RFID Actions

This repository provides a simple solution for executing arbitrary actions (shell commands) via a RFID reader. The ID of an RFID token is used to identify the action, that should be executed.

## Concept
We will use a cheap USB RFID reader to read RFID tags; an example for such a reader would be the the [Neuftech RFID reader for EM4100 and TK4100 cards](https://www.amazon.de/dp/B018OYOR3E) but basically any reader that is recognized as keyboard device will do it. Once the script is started, the RFID reader will be disabled as keyboard input device to prevent the reader from interfering with your normal user session. After that, the raw key events of the device will be processed, which is why the script must have enough privileges to access the input device. The script assumes that the RFID reader will send the ID of the presented token as key presses, followed by a press to ENTER. The ID of the reader can then be used to trigger actions like e.g. start/stop music, turn on the lights in your smart home, etc.

## Usage

- Check that you have `xinput` and `evtest` installed on your system
- Copy the `config.example.sh` to `config.sh` and adjust the values in there
- Create a script `actions.sh` that will be called with the tag ID as first argument. You may use `actions.example.sh` as starting point.

After that, simply execute `sudo ./start.sh`

## License
This project is licensed under the terms of the Apache License 2.0 . See [LICENSE.txt](./LICENSE.txt) for more information.
