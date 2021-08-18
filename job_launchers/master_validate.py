import argparse
import subprocess
from pathlib import Path
from shlex import quote

argparser = argparse.ArgumentParser()
argparser.add_argument("experiment_dir", type=Path)
argparser.add_argument("--corpus", type=str,
                       default="X.SpeakerDiarization.BBT2")
argparser.add_argument("--train_corpus", type=str)
argparser.add_argument("--dry_run", action='store_true')

METRIC = "fscore"

args = argparser.parse_args()
launcher_file = Path(__file__).parent / Path("launchers") / Path("validate.sh")

if args.train_corpus is None:
    print("Assuming train corpus is the same as validation corpus")
    args.train_corpus = args.corpus

train_dir = f"{args.experiment_dir}/train/{args.train_corpus}.train"
assert Path(train_dir).is_dir()

log_file = f"validate_{args.corpus}_{args.experiment_dir.name}_{METRIC}.log"
command_args = [
    "sbatch",
    "-o", log_file,
    str(launcher_file), args.corpus, train_dir
]
command_str = " ".join(quote(s) for s in command_args)
print(f"Lauching job with command {command_str}")
if not args.dry_run:
    subprocess.Popen(command_args)
