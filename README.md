# ScheduleSRM

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/LiveWiresSRM2023/srm_auto_timetable_app/.github%2Fworkflows%2Fmain.yml) ![Static Badge](https://img.shields.io/badge/Contributors-2-blue) ![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/LiveWiresSRM2023/srm_auto_timetable_app/Main) ![Website](https://img.shields.io/website?url=https%3A%2F%2Fsrmtt.livewires.tech&up_message=online)

ScheduleSRM is built and mainted by [LiveWires_](https://livewires.tech)

## This repo hosts:
- `/json` - contains all the timetable in JSON format
- `/python` - contains all the utility scripts
    - `day_order.py` - AppWrite function reponsible for returning the current day order
    - `send_notification.py` - AppWrite function responsible for invoking a notification
    - `transpose_csv.py` - Utility script to convert CSV (timetable from the Dept.) to JSON
- `/lib` - contains the src for the web app
- `/web` - contains the web specific src

## Tech stack:
- [Flutter](https://flutter.dev) - Frontend
- [Python](https://python.org) - Backend
- [OneSignal](https://onesignal.com) - Notification service
- [AppWrite](https://appwrite.io) - Backend hosting
- [CloudFlare](https://cloudflare.com) - Frontend hosting

## Get started
- Clone the repo
- Setup Flutter environment
- Run `flutter doctor` to ensure the platform is setup properly
- Open the Folder and run `flutter run -d chrome` to run debug session in Chrome

## Contributors
<a href="https://github.com/LiveWiresSRM2023/srm_auto_timetable_app/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=LiveWiresSRM2023/srm_auto_timetable_app" />
</a>

## Contributing
We welcome contributions! To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch: 
    ```sh
    git checkout -b feature/your-feature
    ```
3. Make your changes and commit them:
    ```sh
    git commit -m 'Add some feature'
    ```
4. Push to the branch:
    ```sh
    git push origin feature/your-feature
    ```
5. Open a pull request.
