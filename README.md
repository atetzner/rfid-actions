# RFID Actions

This repository provides a simple solution for executing arbitrary actions (shell commands) via a RFID reader. The ID of an RFID token is used to identify the action, that should be executed.

## Concept
We will use a cheap USB RFID reader to read RFID tags; an example for such a reader would be the the [Neuftech RFID reader for EM4100 and TK4100 cards](https://www.amazon.de/dp/B018OYOR3E) but basically any reader that is recognized as keyboard device will do it. Once the script is started, the raw key events of the device will be processed using `evtest`, which is why the script must have enough privileges to access the input device. The script assumes that the RFID reader will send the ID of the presented token as key presses, followed by a press to ENTER. The ID of the reader can then be used to trigger actions like e.g. start/stop music, turn on the lights in your smart home, etc.

## Usage

- Check that you have `xinput` and `evtest` installed on your system
- Make sure that you have disabled the RFID reader as a regular keyboard input device to your TTYs:
  - Find the UDEV name of your RFID reader:
    ```bash
    udevadm info --name=/dev/input/by-id/XXXX --attribute-walk | grep 'ATTRS{name}'
    ```
  - Create an UDEV rule e.g. in `/etc/udev/rules.d/99-rfid-reader-ignore.rules` using the UDEV name
    ```
    ATTRS{name}=="<NAME-FROM-ABOVE>", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    ```
  - Reload UDEV rules
    ```bash
    sudo udevadm control --reload
    sudo udevadm trigger
    ```
- Copy the `config.example.sh` to `config.sh` and adjust the values in there
- Create a script `actions.sh` that will be called with the tag ID as first argument. You may use `actions.example.sh` as starting point.

After that, simply execute `sudo ./start.sh`

## License
This project is licensed under the terms of the Apache License 2.0 . See [LICENSE.txt](./LICENSE.txt) for more information.
