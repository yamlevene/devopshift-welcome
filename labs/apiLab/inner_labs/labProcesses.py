import subprocess as sp


def run_subprocess(commands_list: list) -> str:

    p = sp.run(commands_list, stdout=sp.PIPE, stderr=sp.PIPE)

    output_str = p.stdout.decode()
    err_str = p.stderr.decode()

    if p.returncode == 0:
        return output_str

    elif p.returncode == 1:
        return err_str

    elif p.returncode == 2:
        return err_str


if __name__ == '__main__':
    print(run_subprocess("wsl ls -a -l /var/log".split()))
    print(run_subprocess("wsl systemctl status nginx.".split()))
