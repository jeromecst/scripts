#!/usr/bin/env python

import datetime as dt
from tokenize import String


class Color:
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    DARKCYAN = '\033[36m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'


class Person:
    name = str
    birthdate = dt.date

    def __init__(self, name, birthdate):
        self.birthdate = birthdate
        self.name = name

    def birthday(self):
        return str(self.birthdate.day) + " " + str(self.birthdate.month)


def extract_date_from_string(datedate):
    strings_date = datedate.split("/", 3)
    try:
        return int(strings_date[2]), int(strings_date[1]), int(strings_date[0])
    except IndexError:
        return 1, int(strings_date[1]), int(strings_date[0])


class BirthdayManager:
    currDate = dt.date.today()
    filepath = String
    list_of_person = []

    def __init__(self, filepath):
        self.filepath = filepath
        self.__extract_persons()

    def __extract_persons(self):
        try:
            myfile = open(fp, 'r')
            for line in myfile:
                strings_line = line.split('|', 2)
                name = strings_line[0].rstrip()
                date = strings_line[1].replace(" ", "").replace("\n", "")
                year, months, day = extract_date_from_string(date)
                self.add_persons(Person(name, dt.date(year, months, day)))
        except FileNotFoundError:
            print("file not found")
            exit()

    def add_persons(self, p):
        self.list_of_person.append(p)

    def next_birthdays(self, days):
        year = self.currDate.year
        if year % 4 != 0:
            leap = False
        elif year % 100 != 0:
            leap = True
        elif year % 400 != 0:
            leap = False
        else:
            leap = True
        if leap:
            year = 400
        else:
            year = 1
        for i in range(days):
            date2 = (self.currDate.replace(year=year) + dt.timedelta(days=i))
            for p in self.list_of_person:
                if date2.__eq__(p.birthdate.replace(year=year)):
                    name = Color.BOLD + p.name + Color.END
                    if i == 0:
                        if p.birthdate.year > 100:
                            print(name, "fête ses", self.currDate.year - p.birthdate.year, "ans aujourd'hui !!!")
                        else:
                            print("Anniversaire de", name, "aujourd'hui !!!")
                    else:
                        if p.birthdate.year > 100:
                            print(name, "fête ses", self.currDate.year - p.birthdate.year, "ans dans", i, "jours")
                        else:
                            print("Anniversaire de", name, "dans", i, "jours")


fp = "/home/jerome/.jserv/notes/bd.md"

BD = BirthdayManager(fp)
BD.next_birthdays(60)
