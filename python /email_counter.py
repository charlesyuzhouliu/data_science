# most_common_words.py
import sys, os
from collections import Counter

if __name__ == "__main__":

    os.chdir("/Users/yuzhouliu/Desktop/github/data_science/python ")
    # pass in number of words as first argument
    try:
        most_pop = int(sys.argv[1])
    except:
        print("Error: user has to provide numeric argument!")
        sys.exit(1)   # non-zero exit code indicates error

    def get_domain(email_addr):
        """ split on @ and return the last piece"""
        return email_addr.lower().split("@")[-1].split(".")[0]

    with open('emails.txt', 'r') as email_file:
        domain_counts = Counter(get_domain(line.strip())
                                for line in email_file
                                if "@" in line)

    for domain, count in domain_counts.most_common(most_pop):
        sys.stdout.write(domain)
        sys.stdout.write("\t")
        sys.stdout.write(str(count))
        sys.stdout.write("\n")
