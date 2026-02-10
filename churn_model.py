import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Load Data
def load_data(filepath):
    return pd.read_csv(filepath)

# Train Model
def train_churn_model(df):
    X = df[['days_since_login', 'total_spend', 'support_tickets']]
    y = df['churn']
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
    
    model = RandomForestClassifier(n_estimators=100)
    model.fit(X_train, y_train)
    
    predictions = model.predict(X_test)
    print(f"Model Accuracy: {accuracy_score(y_test, predictions)}")

if __name__ == "__main__":
    print("Starting Churn Prediction Training...")
