# Overview

{% hint style="success" %}
Import audio recordings with their segment labels and the project's spectrogram settings in the Supervisely format. A downloaded Audio project is already in this format.
{% endhint %}

{% hint style="info" %}
All information about the Supervisely audio annotation format can be found [here](../../../Annotation-JSON-format/10_Supervisely_format_audio.md).
{% endhint %}

# Format description

**Supported audio formats:** `.wav`, `.flac`, `.mp3`, `.ogg`, `.m4a`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`<br>
**Data structure:** Information is provided below.

# Input files structure

Both a directory and an archive are supported. Each dataset is a directory with `audio` and `ann` subdirectories; nested datasets are stored in a `datasets` subdirectory of their parent.

```text
📦 project_name
├── 📄 meta.json
└── 📂 dataset_name
    ├── 📂 audio
    │   ├── 🎵 recording_01.wav
    │   └── 🎵 recording_02.flac
    ├── 📂 ann
    │   ├── 📄 recording_01.wav.json
    │   └── 📄 recording_02.flac.json
    └── 📂 datasets
        └── 📂 nested_dataset_name
            ├── 📂 audio
            └── 📂 ann
```

# What is imported

* **Recordings**, unchanged.
* **Segments**, matched to the destination project's tags by name. A tag that conflicts with an existing one is renamed, as for other project types. Ids from the source are replaced.
* **Datasets**, including nested ones.
* **Spectrogram settings** from `meta.json`, but only when the destination project has none yet and holds no recordings. A project that is already configured, or already has recordings, keeps its own settings, because changing them would change what its existing labels mean; the import log says when the imported settings differ.
