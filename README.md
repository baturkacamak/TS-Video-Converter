# TS-Video-Converter

This script `ts-converer.sh` is designed to download Transport Stream (TS) video files from a specified URL pattern, combine them, and convert the combined file into an MP4 format.

## Getting Started

These instructions will get you a copy of the script up and running on your local machine for development and testing purposes.

### Prerequisites

Before running this script, you must have `curl` and `ffmpeg` installed on your system. The script includes a function to check and install these tools if they are not already installed.

### Installing

To use the TS-Video-Converter script, follow these steps:

1. Find the `ts-converter.sh` file in the list of files.
2. Click on `ts-converter.sh` to view the file.
3. Right-click the `Raw` button near the top right of the file and select `Save link as...` to download the script to your computer.
4. Choose a location on your computer to save the file and click `Save`.
5. Open Terminal on your computer:
    - **For macOS**: Press `Command + Space` to open Spotlight Search, type `Terminal`, and press `Enter`.
    - **For Linux**: Press `Ctrl + Alt + T` to open Terminal.
    - **For Windows**: Press `Windows key` to open Start Menu, type `cmd`, and press `Enter` to open Command Prompt.

6. Change directory to where you downloaded `ts-converter.sh` using the `cd` command. For example:

```bash
cd Downloads
````


7. Run the script with the required parameters:

```bash
./ts-converer.sh <base_url> <file_pattern>
```

- Replace `<base_url>` with the URL directory that contains the TS files.
- Replace `<file_pattern>` with the file naming pattern, using `{i}` to represent where the incrementing number will go.

Example:

```bash
./ts-converer.sh https://example.com/path/to/files/ 'seg-{i}-v1-a1.ts'
```

### Finding URLs

#### Opening Developer Tools

1. **Open Your Web Browser**: Launch your preferred web browser. This guide will use Google Chrome as an example, but most modern browsers have similar developer tools.

2. **Access Developer Tools**:
    - For Windows/Linux: Press `Ctrl` + `Shift` + `I` simultaneously on your keyboard.
    - For macOS: Press `Command` + `Option` + `I` simultaneously on your keyboard.

   Alternatively, you can right-click on the webpage and select `Inspect` or go to the browser menu (usually three dots or lines in the corner), select `More tools`, and then `Developer tools`.

3. **Navigate to the 'Network' Tab**: At the top of the Developer Tools panel that appears, there will be a row of tabs such as Elements, Console, Sources, etc. Click on the `Network` tab. If you don't see it immediately, you may have to click on the `>>` symbol to reveal more tabs.

#### Using the Network Tab to Find Files

1. **Load or Reload the Webpage**: With the Network tab open, reload the webpage by clicking the refresh button next to the address bar, or press `F5` (Windows/Linux) or `Command` + `R` (macOS). This action starts recording the network activity.

2. **Start and Stop Video Playback**: If the video is embedded on the webpage, start and stop the video playback by clicking on the play/pause button. This action triggers the loading of video segments, making them visible in the network activity.

3. **Filter by File Type**: To focus on `.ts` files, use the filter bar at the top of the network activity list. Click on the `Media` filter to see video files, images, and other media types, or use the search bar to type in `.ts` and press Enter to filter for only those files.

4. **Find File Details**: Click on a file name in the list to see more details about that file in a side panel. This can include the file’s status (if it has loaded correctly), type (like `xhr` for data requests), initiator (what caused the file to load), and size.

5. **Download or Access the File**: Right-click on the file name in the list and choose `Open in new tab` or `Copy link address` to get the file's URL, which you can paste into your browser's address bar to access directly.

6. **Stop Recording**: Once you've found what you're looking for, stop the network recording by clicking the red circle button at the top-left of the Network tab. It turns gray when it's not recording.

## Usage

After downloading and setting up, you can run the script as described above. The script will download the `.ts` files to a temporary directory, combine them, and then convert to an `.mp4` file in your current directory.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/YourUsername/TS-Video-Converter/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Your Name** - *Initial work* - [YourUsername](https://github.com/YourUsername)

See also the list of [contributors](https://github.com/YourUsername/TS-Video-Converter/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
