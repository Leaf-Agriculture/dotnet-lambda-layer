import subprocess


def handler(e, c):
    subprocess.run(['ls', '-l', '/opt/bin'])
    subprocess.run(['dotnet', '--list-sdks'])
    subprocess.run(['dotnet', '--list-runtimes'])
    subprocess.run(['dotnet', 'nice/out/nice.dll'])
    return e
