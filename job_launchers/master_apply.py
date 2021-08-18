import argparse
import subprocess
from pathlib import Path
from shlex import quote

argparser = argparse.ArgumentParser()
argparser.add_argument("experiment_dir", type=Path)
argparser.add_argument("--corpus", type=str,
                       default="X.SpeakerDiarization.BBT2")
argparser.add_argument("--train_corpus", type=str)
argparser.add_argument("--dev_corpus", type=str)
argparser.add_argument("--subset", type=str, choices=["train", "development", "test"],
                       default="test")
argparser.add_argument("--dry_run", action='store_true')

args = argparser.parse_args()

launcher_file = Path(__file__).parent / Path("launchers") / Path("apply.sh")

METRIC = "fscore"

if args.dev_corpus is None:
    print("Assuming dev corpus is the same as application corpus")
    args.dev_corpus = args.corpus

if args.train_corpus is None:
    print("Assuming train corpus is the same as dev corpus")
    args.train_corpus = args.dev_corpus

validate_dir = f"{args.experiment_dir}/train/{args.train_corpus}.train/validate_average_detection_{METRIC}/{args.dev_corpus}.development"
print(validate_dir)
assert Path(validate_dir).is_dir()

log_file = f"apply_{args.corpus}_{args.experiment_dir.name}_{METRIC}.log"
command_args = [
    "sbatch",
    "-o", log_file,
    str(launcher_file), args.corpus, validate_dir, args.subset
]

command_str = " ".join(quote(s) for s in command_args)
print(f"Lauching job with command {command_str}")
if not args.dry_run:
    subprocess.Popen(command_args)
