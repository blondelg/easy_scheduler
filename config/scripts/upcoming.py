import pandas as pd
import os
from datetime import datetime, date, timedelta
from tabulate import tabulate

"""
This Script transforms the output of print_timer.sh script into a table with
upcoming reports for 2 days
"""

# store output of print_timer.sh script into a string
output = os.popen("./print_timer.sh").read().split('\n')
week = ['Mon','Tue','Wed','Thu','Fri', 'Sat', 'Sun']

def next_date(df):
    """
    from a week day lin Mon, Tue, Wed, and an hour like 02:24:20, give the date
    of the next day from today
    """
    week_day = df['week_day']
    hour = df['hour']
    week_days = {
                'Mon': 0,
                'Tue': 1,
                'Wed': 2,
                'Thu': 3,
                'Fri': 4,
                'Sat': 5,
                'Sun': 6
                }
    week_days_r = dict()
    for key in week_days:
        week_days_r[week_days[key]] = key

    int_day = datetime.today().weekday()
    str_day = week_days_r[int_day]

    week_days_delta = dict()
    for key in week_days:

        if week_days[key] - int_day >= 0:
            week_days_delta[key] = week_days[key] - int_day
        else:
            week_days_delta[key] = week_days[key] - int_day + 7

    date = datetime.today() + timedelta(days=week_days_delta[week_day])

    str_datetime = date.strftime("%Y%m%d")+ " " + hour

    return datetime.strptime(str_datetime, "%Y%m%d %H:%M:%S")



next_runs = pd.DataFrame(columns=['report_name', 'week_day', 'hour'])

report = ''
for elt in output:
    if ".timer" in elt:
        report = elt
    if "OnCalendar" in elt:
        #print(report, elt)

        #check if there is special week days
        temp_week = []
        for day in week:
            if day in elt:
                temp_week.append(day)

        # if no day have been detected, take all week days
        if len(temp_week) == 0:
            temp_week = week

        for day in temp_week:
            next_runs = next_runs.append({
                    'report_name': report,
                    'week_day': day,
                    'hour': elt[-8:]
                    },ignore_index=True)


next_runs['next_run'] = next_runs.apply(lambda x: next_date(x), axis=1)
next_runs['time_to_trigger'] = next_runs['next_run'].apply(lambda x: datetime.strptime(str(x), "%Y-%m-%d %H:%M:%S") - datetime.today())
next_runs['past_check'] = next_runs['time_to_trigger'].apply(lambda x: x.days)
next_runs = next_runs[next_runs['past_check'] > - 1]
next_runs = next_runs[next_runs['past_check'] < 2]
next_runs = next_runs.sort_values('next_run')
next_runs['time_to_trigger'] = next_runs['time_to_trigger'].dt.round('1s')
next_runs['report_name'] = next_runs['report_name'].apply(lambda x: x.split("[")[2][2:])
next_runs['report_name'] = next_runs['report_name'].apply(lambda x: x[:-1])
next_runs['report_name'] = next_runs['report_name'].apply(lambda x: x.replace(".timer",""))
next_runs['time_to_next'] = 0
next_runs['time_to_next'] = next_runs['next_run'].shift(-1) - next_runs['next_run']
next_runs['time_to_next'] = next_runs['time_to_next'].astype(str).str.extract('days (.*?)\.')

#print(next_runs)
print(tabulate(next_runs[['report_name', 'week_day', 'hour', 'next_run', 'time_to_trigger','time_to_next']],
                    headers=['Script Name', 'Day', 'Hour', 'Next Run', 'Time Until Next','Delta To Next'], tablefmt='psql',showindex=False))
