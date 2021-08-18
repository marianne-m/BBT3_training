import argparse
import subprocess
from pathlib import Path
from shlex import quote

argparser = argparse.ArgumentParser()
argparser.add_argument("experiment_dir", type=Path)
argparser.add_argument("--protocol", type=str, default="X.SpeakerDiarization.BBT2")
argparser.add_argument("--dry_run", action='store_true')


args = argparser.parse_args()
launcher_file = Path(__file__).parent / Path("launchers") / Path("train.sh")

log_file = f"train_{args.protocol}_{args.experiment_dir.name}.log"
command_args = [
    "sbatch",
    "-o", log_file,
    str(launcher_file), str(args.experiment_dir), args.protocol
]

command_str = " ".join(quote(s) for s in command_args)
print(f"Lauching job with command {command_str}")
if not args.dry_run:
    subprocess.Popen(command_args)