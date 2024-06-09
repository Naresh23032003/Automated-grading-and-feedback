<?php
require('fpdf.php'); // Ensure this path is correct and points to the FPDF file

function fetchAnswerScore($question, $userAnswer, $correctAnswer, $max_score) {
    $apiKey = 'Groq API key'; // Replace with your Groq API key

    $models = ["llama3-8b-8192", "gemma-7b-it", "mixtral-8x7b-32768"];
    $scores = [];

    foreach ($models as $model) {
        $data = array(
            "model" => $model,
            "messages" => [
                ["role" => "system", "content" => "You should score the below questions out of $max_score marks
                            Sample Prompts and Responses:
                            Sample 1:
                            Prompt: Assess the response provided below:\n Question: How long was Lincoln's legal Career? \n Correct Answer: 23 years \nUser Answer: Life expectancy of men in Finland is 72 years for a maximum score of 4.
                            Response: 4
                            Sample 2:
                            Prompt: Assess the response provided below:\n Question: What is the life expectancy for men in Finland?\n Correct Answer: 75 years \nUser Answer: Life expectancy of men in Finland is 72 years for a maximum score of 4.
                            Response: 3
                            Sample 3:
                            Prompt: Assess the response provided below:\n Question: What does a polar bear's fur provide? \n Correct Answer: A polar bear's fur provides camouflage and insulation \nUser Answer: Polar bear’s fur provides insulation for a maximum score of 4.
                            Response: 2
                            "], //Used YouData.ai dataset for few shot prompting
                ["role" => "user", "content" => "Assess the response provided below:\nQuestion: $question\nCorrect Answer: $correctAnswer\nUser Answer: $userAnswer\n for a maximum score of  $max_score dont give more marks than maximum score.         
                "]
            ],
            "temperature" => 0
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://api.groq.com/openai/v1/chat/completions');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));

        $headers = array(
            'Content-Type: application/json',
            'Authorization: Bearer ' . $apiKey
        );
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $response = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
            continue;
        }
        curl_close($ch);

        $response = json_decode($response, true);

        if (isset($response['choices'][0]['message']['content'])) {
            $content = $response['choices'][0]['message']['content'];
            if (preg_match('/\d+(\.\d+)?/', $content, $matches)) {
                $scores[] = floatval($matches[0]);
            }
        }
    }

    if (count($scores) > 0) {
        $averageScore = round(array_sum($scores) / count($scores), 2);
        return $averageScore;
    }
    return null;
}

function fetchFeedback($question, $userAnswer, $correctAnswer, $criteria, $max_score, $score) {
    $apiKey = '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'; // Replace with your Groq API key

    $data = array(
        "model" => "llama3-8b-8192",
        "messages" => [
            ["role" => "system", "content" => "You are a knowledgeable and constructive exam evaluator. I will provide you with an exam question, the correct answer, and a student's answer. Your task is to give concise and specific feedback in less than 50 words to the student.

            Your feedback should highlight what is lacking in the student's answer and provide clear guidance on how to improve it.

            If the student scored full marks on the question, just provide an appreciating reply without commenting on improvement.

            Please be encouraging and focus on actionable advice.

            Just jump straight into the feedback; do not start the output with constructs like 'Here's your feedback' and more.

            Exam Question:

            Explain the process of photosynthesis in plants.

            Correct Answer:

            Photosynthesis is the process by which green plants use sunlight to synthesize foods with the help of chlorophyll, which absorbs light energy. The process involves the intake of carbon dioxide and water, which are converted into glucose and oxygen. The overall chemical reaction is: 6CO2 + 6H2O + light energy → C6H12O6 + 6O2. This process primarily occurs in the chloroplasts within plant cells.

            Student's Answer:

            Photosynthesis is when plants use sunlight to make their food. They take in carbon dioxide and release oxygen.

            Marks obtained:

            7/10

            Feedback:

            Your answer correctly identifies that plants use sunlight to make food and mentions the intake of carbon dioxide and release of oxygen. However, it lacks detail on the specific processes involved, such as the role of chlorophyll and the conversion of water and carbon dioxide into glucose. To improve, include information about chlorophyll's role in absorbing light energy and the overall chemical reaction: 6CO2 + 6H2O + light energy → C6H12O6 + 6O2. Also, mention that this occurs in the chloroplasts."
            ],
            ["role" => "user", "content" => "Provide feedback for question: $question \n on the basis of $criteria for the following answer:\nCorrect Answer: $correctAnswer\nUser Answer: $userAnswer.\n Student got a score of $score out of $max_score"]
        ]
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://api.groq.com/openai/v1/chat/completions');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));

    $headers = array(
        'Content-Type: application/json',
        'Authorization: Bearer ' . $apiKey
    );
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $response = curl_exec($ch);
    if (curl_errno($ch)) {
        echo 'Error:' . curl_error($ch);
        return 'Error fetching feedback.';
    }
    curl_close($ch);

    $response = json_decode($response, true);

    if (isset($response['choices'][0]['message']['content'])) {
        return $response['choices'][0]['message']['content'];
    }
    return 'Error: No feedback provided.';
}

function generatePDF($questions, $filename, $id, $totalScore, $over) {
    
    $pdf = new FPDF('P', 'mm', 'A4');
    $pdf->AliasNbPages();
    $pdf->AddPage();
    $pdf->SetFont('helvetica', '', 12);

    // Header Formatting
    $pdf->Cell(0, 10, 'Name: Naresh', 0, 0, 'L');
    $pdf->Cell(0, 10, 'Date: 22/05/2024', 0, 1, 'R');

    $pdf->Cell(0, 10, 'Test ID: ' . $id, 0, 0, 'L');
    $marks_obtained = $totalScore;
    $total_marks = $over;
    $pdf->Cell(0, 10, 'Marks Obtained: ' . $marks_obtained . '/' . $total_marks, 0, 1, 'R');

    $pdf->Ln(5);
    $pdf->SetLineWidth(1);
    $pdf->SetMargins(10, 10, 10); 
    $pdf->Ln(5);

    // Generate QuickChart URLs
    $scores = array_map(function($q) { return $q['score']; }, $questions);
    
    //$pieChartURL = generatePieChartURL($questions);
    //$lineChartURL = generateLineChartURL($questions);

    // Add graphs to PDF
    
    //$pdf->Ln(90);

    //$pdf->Image($pieChartURL, 10, 160, 90, 0, 'PNG');
    //$pdf->Image($lineChartURL, 110, 160, 90, 0, 'PNG');
    //$pdf->Ln(100);

    // Iterate through questions data
    $question_id = 0;
    foreach ($questions as $question) {
        $question_id += 1;
        $questio = $question['question'];
        $correct_answer = $question['correct_answer'];

        // Get student response
        $response = $question['user_answer'];
        $feedback = $question['feedback'];
        $awarded_marks = $question['score'];
        $actual_marks = $question['max'];

        // Set fill color based on marks awarded
        if ($awarded_marks >= $actual_marks - 3) {
            $pdf->SetFillColor(198, 245, 204);
        } elseif ($awarded_marks == 0) {
            $pdf->SetFillColor(252, 210, 204);
        } else {
            $pdf->SetFillColor(237, 230, 192);
        }

        $pdf->SetLineWidth(0.5);
        $pdf->MultiCell(0, 10, "$question_id: $questio [$actual_marks marks]\nStudent Response: $response\nCorrect Answer: $correct_answer\nFeedback: $feedback\nMarks Awarded: $awarded_marks", 1, 'L', true);
        $pdf->Ln(5);
    }
    $barChartURL = generateQuickChartURL($scores);
    $pdf->Image($barChartURL, 10, 60, 180, 0, 'PNG');
    // Output PDF
    $pdf->Output('F', $filename);
}

// Example functions to generate chart URLs
function generateQuickChartURL($data) {
    $baseURL = "https://quickchart.io/chart?";
    $chartConfig = [
        'type' => 'bar',
        'data' => [
            'labels' => array_map(function($i) { return 'Q' . $i; }, range(1, count($data))),
            'datasets' => [[
                'label' => 'Scores',
                'data' => $data
            ]]
        ],
        'options' => [
            'title' => [
                'display' => true,
                'text' => 'Marks Distribution'
            ]
        ]
    ];
    $chartParams = 'c=' . urlencode(json_encode($chartConfig));
    return $baseURL . $chartParams;
}

function generatePieChartURL($questions) {
    $correct = 0;
    $incorrect = 0;

    foreach ($questions as $question) {
        if ($question['score'] == $question['max']) {
            $correct++;
        } else {
            $incorrect++;
        }
    }

    $baseURL = "https://quickchart.io/chart?";
    $chartConfig = [
        'type' => 'pie',
        'data' => [
            'labels' => ['Correct', 'Incorrect'],
            'datasets' => [[
                'data' => [$correct, $incorrect]
            ]]
        ],
        'options' => [
            'title' => [
                'display' => true,
                'text' => 'Correct vs Incorrect Answers'
            ]
        ]
    ];
    $chartParams = 'c=' . urlencode(json_encode($chartConfig));
    return $baseURL . $chartParams;
}

function generateLineChartURL($questions) {
    $scores = array_map(function($q) { return $q['score']; }, $questions);
    $baseURL = "https://quickchart.io/chart?";
    $chartConfig = [
        'type' => 'line',
        'data' => [
            'labels' => array_map(function($i) { return 'Q' . $i; }, range(1, count($questions))),
            'datasets' => [[
                'label' => 'Scores',
                'data' => $scores,
                'fill' => false,
                'borderColor' => 'blue'
            ]]
        ],
        'options' => [
            'title' => [
                'display' => true,
                'text' => 'Scores Trend Across Questions'
            ]
        ]
    ];
    $chartParams = 'c=' . urlencode(json_encode($chartConfig));
    return $baseURL . $chartParams;
}

// Assume $conn is the database connection
$examId = $_GET['id'];
$selExam = $conn->query("SELECT * FROM exam_tbl WHERE ex_id='$examId' ")->fetch(PDO::FETCH_ASSOC);


?>

<div class="app-main__outer">
<div class="app-main__inner">
    <div id="refreshData">
        <div class="col-md-12">
            <div class="app-page-title">
                <div class="page-title-wrapper">
                    <div class="page-title-heading">
                        <div>
                            <?php echo $selExam['ex_title']; ?>
                            <div class="page-title-subheading">
                                <?php echo $selExam['ex_description']; ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
            <div class="row col-md-12">
                <h1 class="text-primary">RESULT'S</h1>
            </div>

            <div class="row col-md-6 float-left">
    <div class="main-card mb-3 card" style="font-size: larger; padding: 20px;">
        <div class="card-body">
            <h5 class="card-title">Your Answer's</h5>
            <table class="align-middle mb-0 table table-borderless table-striped table-hover" id="tableList">
            <?php 
                $selQuest = $conn->query("SELECT * FROM exam_question_tbl eqt INNER JOIN exam_answers ea ON eqt.eqt_id = ea.quest_id WHERE eqt.exam_id='$examId' AND ea.axmne_id='$exmneId' AND ea.exans_status='new' ");
                $i = 1;
                $totalScore = 0;
                $questions = [];
                $over = 0;
                while ($selQuestRow = $selQuest->fetch(PDO::FETCH_ASSOC)) {
                    $userAnswer = $selQuestRow['exans_answer'];
                    $correctAnswer = $selQuestRow['exam_answer'];
                    $criteria = $selQuestRow['exam_ch4']; // Marking criteria
                    $max_score = $selQuestRow['exam_ch1'];
                    $score = fetchAnswerScore($selQuestRow['exam_question'], $userAnswer, $correctAnswer, $max_score);
                    $feedback = fetchFeedback($selQuestRow['exam_question'],$userAnswer, $correctAnswer, $criteria, $max_score, $score);

                    // Store data for PDF
                    $questions[] = [
                        'question' => $selQuestRow['exam_question'],
                        'user_answer' => $userAnswer,
                        'correct_answer' => $correctAnswer,
                        'score' => $score !== null ? $score : 0,
                        'max' => $max_score,
                        'feedback' => $feedback
                    ];
                    $id = $selQuestRow['exam_id'];
                    $totalScore += $score !== null ? $score : 0;
                    $over += $selQuestRow['exam_ch1'];
                    ?>
                    <tr>
                        <td>
                            <b><p><?php echo $i++; ?> .) <?php echo $selQuestRow['exam_question']; ?></p></b>
                            <label class="pl-4 text-success">
                                Answer: 
                                <span style="color:<?php echo $score !== null && $score > 0 ? 'green' : 'red'; ?>"><?php echo $userAnswer; ?></span>
                                <br>
                                Score: <span><?php echo $score !== null ? $score : 'Error fetching score'; ?></span>
                                <br>
                                Feedback: <span><?php echo $feedback; ?></span> 
                            </label>
                        </td>
                    </tr>
                <?php }
                $filename = 'feedback.pdf';
                generatePDF($questions, $filename, $id, $totalScore, $over);

                // Update the exam_attempt table with the total score
                $updateScore = $conn->prepare("UPDATE exam_attempt SET score = :totalScore WHERE exam_id = :examId AND exmne_id = :exmneId");
                $updateScore->bindParam(':totalScore', $totalScore);
                $updateScore->bindParam(':examId', $examId);
                $updateScore->bindParam(':exmneId', $exmneId);
                $updateScore->execute();
             ?>
             </table>
        </div>
    </div>
</div>


            <div class="col-md-6 float-left">
                <div class="col-md-12 float-left">
                    <div class="card mb-3 widget-content bg-night-fade" style="min-height: 150px;">
                        <div class="widget-content-wrapper text-white">
                            <div class="widget-content-left">
                                <div class="widget-heading"><h5>Score</h5></div>
                                <div class="widget-subheading" style="color: transparent;">/</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-white">
                                    <span style="font-size: larger;">
                                        <?php 
                                            echo $totalScore;
                                        
                                         ?>
                                    </span> / <?php echo $over; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 float-left">
                    <div class="card mb-3 widget-content bg-happy-green" style="min-height: 150px;">
                        <div class="widget-content-wrapper text-white">
                            <div class="widget-content-left">
                                <div class="widget-heading"><h5>Percentage</h5></div>
                                <div class="widget-subheading" style="color: transparent;">/</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-white">
                                    <span style="font-size: larger;">
                                        <?php 
                                            $ans = $totalScore / $over * 100;
                                            echo number_format($ans, 2);
                                            echo "%";
                                         ?>
                                    </span> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 float-left">
                    <a href="<?php echo $filename; ?>" download="feedback.pdf" class="btn btn-primary">Download Feedback</a>
                </div>
            </div>
        </div>
    </div>
</div>
