# Import useful modules
# os: for path handling
# sys: to end the script
# request: to get the site data
# pandas: data analysis tools
# ConfigParser: to handle configuration file
import os
import sys
import requests
import pandas as pd
from configparser import ConfigParser

# Start
if __name__ == '__main__':
    # Read the configuration file and get the link
    config = ConfigParser()
    config.read(os.path.join(os.getcwd(), 'config.ini'))
    link = config['DATA']['link']

    """/*** 1. Connect to the link and retrieve the info ***/"""
    # Get the info
    r = requests.get(url=link)

    # Place the response into a DataFrame
    # Create 2 auxiliary DataFrames
    others_df = pd.DataFrame()
    owner_df = pd.DataFrame()

    # Iterate the results
    for i, item in enumerate(r.json()['items']):
        
        # Create a DataFrame with the owner dict
        owner = pd.DataFrame(item['owner'], index=[i])
        owner_df = pd.concat([owner_df, owner])
        
        # Remove used dicts
        item.pop('tags')
        item.pop('owner')
        
        # Create a DataFrame with the remaining data
        others = pd.DataFrame(item, index=[i])
        others_df = pd.concat([others_df, others])

    # Concatenate everything
    df = pd.concat([owner_df, others_df], axis='columns')

    # List with the date columns (to convert format later)
    dates_cols = ['last_activity_date',
                  'creation_date',
                  'last_edit_date',
                  'closed_date',
                  'protected_date']

    # Convert from timestamp to DateTime
    for key in dates_cols:
        df[key] = pd.to_datetime(df[key], unit='s')

    # Filter by answered and not answered
    answered = df[df['is_answered'] == True]
    not_answered = df[df['is_answered'] == False]

    """/*** 2. Number of answered and not answered questions ***/"""
    num_answered_questions = answered.index.size
    num_no_answered_questions = not_answered.index.size
    print('2) Respuestas contestadas: {}\n' \
          .format(num_answered_questions) + \
          'Respuestas no contestadas: {}' \
          .format(num_no_answered_questions) + '\n')


    """/*** 3. Answer with least number of views ***/"""
    row = answered.sort_values(by='view_count').iloc[0]
    least_views_qid = row['question_id']
    least_views_link = row['link'][1]
    print('3) El valor "answer_id" para este caso es NaN. '+\
          'Por lo tanto, la identifico con "question_id" '+\
          'y con el "link" a la pregunta:\n'+\
          'question_id: {}\n'.format(least_views_qid)+\
          'link: {}'.format(least_views_link)+'\n')


    """/*** 4. Older and newest answers ***/"""
    rows = answered.sort_values(by='last_activity_date')
    newer_answer_id = int(rows.iloc[0]['accepted_answer_id'])
    older_answer_qid = int(rows.iloc[rows.shape[0]-1]['question_id'])
    older_answer_link = rows.iloc[rows.shape[0]-1]['link'][1]
    print('4) Aquí ocurre lo mismo que lo explicado en 3). '+\
          'Por lo tanto:\nID de la pregunta más actual: {}'\
          .format(newer_answer_id)+'\n'+\
          'question_id de la pregunta más vieja: {}'\
          .format(older_answer_qid)+'\n'+\
          'link de la pregunta más vieja: {}'\
          .format(older_answer_link)+'\n')


    """/*** 5. Response of the owner with the highest reputation ***/"""
    row = answered.sort_values(by='reputation', ascending=False)
    res_highest_rep = int(row.iloc[0]['accepted_answer_id'])
    print('5) ID de la respuesta del owner con mayor reputación: {}'\
          .format(res_highest_rep))
    
    # Finish the script
    sys.exit()