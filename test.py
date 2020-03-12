import subprocess


def handler(e, c):
    subprocess.run(['ls', '-l', '/opt/bin'])
    assert subprocess.run(['dotnet', '--info']).returncode == 0
    return e
